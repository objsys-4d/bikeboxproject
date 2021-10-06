//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oDon)  // COMPANY RECORD
C_OBJECT:C1216($oDonation)  // COMPANY SELECTION

C_OBJECT:C1216($oEvent; $oPerson)
C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="donationList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="dateDonation"
$oSettings.sortField:="dateDonation"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.donationList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','dateDonation','"+Ltg_Str_Localise("%dateDonation")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','nameName','"+Ltg_Str_Localise("%nameName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','eventName','"+Ltg_Str_Localise("%eventName")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.donationList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('companyPageSize','pageSize-"+String:C10(oUser.donationList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.donationList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.donationList.searchFilter="dateDonation")
			
			$oDonation:=ds:C1482.Donation.query("dateDonation = :1"; Date:C102(oUser.donationList.searchString))
			
		: (oUser.donationList.searchFilter="nameName")
			
			$oPerson:=ds:C1482.Person.query("firstName = :1 or lastName = :1"; "@"+oUser.donationList.searchString+"@")
			$oDonation:=$oPerson.Person_Donation
			
		: (oUser.donationList.searchFilter="eventName")
			
			$oEvent:=ds:C1482.Event.query("eventName = :1"; "@"+oUser.donationList.searchString+"@")
			$oDonation:=$oEvent.Event_Donation
			
	End case 
Else 
	
	$oDonation:=ds:C1482.Donation.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.donationList.pageCount:=Abs:C99(Int:C8(-($oDonation.length/(oUser.donationList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472
C_TEXT:C284($eventName; $personName)
C_OBJECT:C1216($oEvtDon; $oPerDon)
For each ($oDon; $oDonation)
	
	// ADD TO DATATABLES (JSON)
	$oEvtDon:=$oDon.Donation_Event
	$oPerDon:=$oDon.Donation_Person
	If ($oEvtDon=Null:C1517)
		$eventName:=""
	Else 
		$eventName:=$oEvtDon.eventName
	End if 
	If ($oPerDon=Null:C1517)
		$personName:=""
	Else 
		$personName:=$oPerDon.lastName+", "+$oDon.Donation_Person.firstName
	End if 
	
	$oDataTable.push(New collection:C1472(""; $oDon.UUID; $oDon.dateDonation; $personName; $eventName))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.donationTotal:=String:C10($oDonation.length; "###,###,###")

oConnection.data.donationDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.donationPageNumber:=String:C10(oUser.donationList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oDonation

