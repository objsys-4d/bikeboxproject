//%attributes = {"shared":true}

// Project Method: Person_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Person]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oPerson)  // Person RECORD
C_OBJECT:C1216($oPersonSelection)  // Person SELECTION

C_TEXT:C284($txtPerson_ID)  // Person UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="personDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW PERSON RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="person"))
	
	// LOAD THE person SELECTION FOR PAGINATION CONTROL
	
	$oPersonSelection:=Person_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('person-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oPerson:=ds:C1482.Person.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Person:15]UUID:1
		//oConnection.data.Person.country:="USA"  //by default
		$oPerson.country:="USA"
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// PERSON_UUID PASSED AS URL PARAMETER?
		
		$txtPerson_ID:=Ltg_URL_GetParam("person")
		
		If ($txtPerson_ID="")
			
			$txtPerson_ID:=oConnection.record
		End if 
		
		// LOAD THE PERSON
		
		$oPerson:=ds:C1482.Person.get($txtPerson_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.personDetail.pageNumber:=$oPerson.indexOf($oPersonSelection)+1
			oUser.personDetail.pageCount:=$oPersonSelection.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oPerson:=$oPersonSelection[oUser.personDetail.pageNumber-1]
		
End case 

C_OBJECT:C1216($oPsn)  //to set the default value of the person pulldown
If ($oPerson.companyID=0)  //blank if new
	$oPsn:=New object:C1471
	$oPsn.companyName:=""
	$oPsn.companyID:=0
Else 
	$oPsn:=ds:C1482.Company.query("companyID = :1"; $oPerson.companyID).first()  //select the person record and display in the pulldown
	If ($oPsn=Null:C1517)  //the case that company record is deleted and person record was not updated.
		$oPsn:=New object:C1471
		$oPsn.companyName:=""
		$oPsn.companyID:=0
	End if 
End if 

//Company Name pulldown
Ltg_JS_Send("ltgSelectDeleteOptions('Person.company')")
C_OBJECT:C1216($oCompany; $oCompanySelection)
$oCompanySelection:=ds:C1482.Company.all().orderBy("companyName asc")
Ltg_JS_Send("ltgSelectAddOption('Person.company','0','')")
Ltg_JS_Send("ltgSelectAddOption('Person.company','-1','Add Company record...')")
For each ($oCompany; $oCompanySelection)
	Ltg_JS_Send("ltgSelectAddOption('Person.company','"+String:C10($oCompany.companyID)+"','"+$oCompany.companyName+"')")
End for each 
Ltg_JS_Send("ltgSelectSetValue('Person.company','"+String:C10($oPsn.companyID)+"')")


State_ltgPulldown("person"; $oPerson.state)

// UPDATE CONNECTION DATA...

oConnection.data.Person:=$oPerson  // PERSON

//oConnection.data.personActive:=$oPerson.personObject.active
If ($oPerson.personObject.active="Yes")
	Ltg_JS_Send("ltgObj('.personActive').prop('checked', true)")
Else 
	Ltg_JS_Send("ltgObj('.personActive').prop('checked', false)")
End if 

If ($oPerson.personObject.valid="Yes")
	Ltg_JS_Send("ltgObj('.personValid').prop('checked', true)")
Else 
	Ltg_JS_Send("ltgObj('.personValid').prop('checked', false)")
End if 

If ($oPerson.personObject.duplicateName="Yes")
	Ltg_JS_Send("ltgObj('.personDuplicate').prop('checked', true)")
Else 
	Ltg_JS_Send("ltgObj('.personDuplicate').prop('checked', false)")
End if 


oConnection.data.personStatus:=$oPerson.personObject.status

//Ltg_JS_Send("ltgObj('Person.company')
//oConnection.data.Person.company:=$oPerson.Person_Company.companyName

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.personPageCount:=String:C10(oUser.personDetail.pageCount)
oConnection.data.personPageNumber:=String:C10(oUser.personDetail.pageNumber)