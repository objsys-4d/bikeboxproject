//%attributes = {"shared":true}

// Project Method: Donation_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for Donation
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oDon)  // Donation RECORD
C_OBJECT:C1216($oDonation)  // Donation SELECTION

C_TEXT:C284($txtDonation_ID)  // Donation UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="donationDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW Donation RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="donation"))
	
	// LOAD THE Donation SELECTION FOR PAGINATION CONTROL
	
	$oDonation:=Donation_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('donation-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oDon:=ds:C1482.Donation.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Donation:20]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// Donation UUID PASSED AS URL PARAMETER?
		
		$txtDonation_ID:=Ltg_URL_GetParam("donation")
		
		If ($txtDonation_ID="")
			
			$txtDonation_ID:=oConnection.record
		End if 
		
		// LOAD THE Donation
		
		$oDon:=ds:C1482.Donation.get($txtDonation_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.donationDetail.pageNumber:=$oDon.indexOf($oDonation)+1
			oUser.donationDetail.pageCount:=$oDonation.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oDon:=$oDonation[oUser.donationDetail.pageNumber-1]
		
End case 

//Person pulldown
C_OBJECT:C1216($oPsn)
If ($oDon.personID=0)
	$oPsn:=New object:C1471
	$oPsn.personID:=0
Else 
	$oPsn:=ds:C1482.Person.query("personID = :1"; $oDon.personID).first()
	If ($oPsn=Null:C1517)
		$oPsn:=New object:C1471
		$oPsn.personID:=0
	End if 
End if 

//Person Name pulldown
C_TEXT:C284($personName)
Ltg_JS_Send("ltgSelectDeleteOptions('Donation.personID')")
C_OBJECT:C1216($oPer; $oPerson)
$oPerson:=ds:C1482.Person.all().orderBy("lastName asc")
Ltg_JS_Send("ltgSelectAddOption('Donation.personID','0','"+$personName+"')")  //to clear
Ltg_JS_Send("ltgSelectAddOption('Donation.personID','-1','Add Person record...')")  //to add
For each ($oPer; $oPerson)
	$personName:=$oPer.lastName+", "+$oPer.firstName
	Ltg_JS_Send("ltgSelectAddOption('Donation.personID','"+String:C10($oPer.personID)+"','"+$personName+"')")
End for each 
Ltg_JS_Send("ltgSelectSetValue('Donation.personID','"+String:C10($oPsn.personID)+"')")



//Event pulldown
Event_objPulldown($oDon.eventID)


// UPDATE CONNECTION DATA...
C_OBJECT:C1216($oDonPerson)
$oDonPerson:=$oDon.Donation_Person
If ($oDonPerson=Null:C1517)
	$personName:=""
Else 
	$personName:=$oDonPerson.lastName+", "+$oDonPerson.firstName
End if 
oConnection.data.personName:=$personName

$oEvt:=$oDon.Donation_Event
If ($oEvt=Null:C1517)
	$eventName:=""
Else 
	$eventName:=$oEvt.eventName
End if 
oConnection.data.eventName:=$eventName

oConnection.data.Donation:=$oDon  // Donation

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.donationPageCount:=String:C10(oUser.donationDetail.pageCount)
oConnection.data.donationPageNumber:=String:C10(oUser.donationDetail.pageNumber)