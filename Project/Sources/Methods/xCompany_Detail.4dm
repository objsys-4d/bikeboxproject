//%attributes = {"shared":true}

// Project Method: Company_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Companies]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oCompany)  // COMPANY RECORD
C_OBJECT:C1216($oCompanies)  // COMPANIES SELECTION

C_TEXT:C284($txtCompany_ID)  // COMPANY ID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="companiesDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW COMPANY RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="companies"))
	
	// LOAD THE COMPANIES SELECTION FOR PAGINATION CONTROL
	
	$oCompanies:=Companies_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('companies-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oCompany:=ds:C1482.Companies.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Companies:6]Company_ID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// COMPANY_ID PASSED AS URL PARAMETER?
		
		$txtCompany_ID:=Ltg_URL_GetParam("company")
		
		If ($txtCompany_ID="")
			
			$txtCompany_ID:=oConnection.record
		End if 
		
		// LOAD THE COMPANY
		
		$oCompany:=ds:C1482.Companies.get($txtCompany_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.companiesDetail.pageNumber:=$oCompany.indexOf($oCompanies)+1
			oUser.companiesDetail.pageCount:=$oCompanies.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oCompany:=$oCompanies[oUser.companiesDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Company:=$oCompany  // COMPANY

oConnection.data.companiesPageCount:=String:C10(oUser.companiesDetail.pageCount)
oConnection.data.companiesPageNumber:=String:C10(oUser.companiesDetail.pageNumber)

