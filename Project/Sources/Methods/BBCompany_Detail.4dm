//%attributes = {"shared":true}

// Project Method: BBCompany_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Company]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oCompany)  // Company RECORD
C_OBJECT:C1216($oCompanySelection)  // Company SELECTION

C_TEXT:C284($txtCompany_ID)  // Company UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="companyDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW COMPANY RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="company"))
	
	// LOAD THE company SELECTION FOR PAGINATION CONTROL
	
	$oCompanySelection:=BBCompany_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('company-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oCompany:=ds:C1482.Company.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Company:16]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// COMPANY_ID PASSED AS URL PARAMETER?
		
		$txtCompany_ID:=Ltg_URL_GetParam("company")
		
		If ($txtCompany_ID="")
			
			$txtCompany_ID:=oConnection.record
		End if 
		
		// LOAD THE COMPANy
		
		$oCompany:=ds:C1482.Company.get($txtCompany_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.companyDetail.pageNumber:=$oCompany.indexOf($oCompanySelection)+1
			oUser.companyDetail.pageCount:=$oCompanySelection.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oCompany:=$oCompanySelection[oUser.companyDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...
State_ltgPulldown("company"; $oCompany.state)

oConnection.data.Company:=$oCompany  // COMPANY

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.companyPageCount:=String:C10(oUser.companyDetail.pageCount)
oConnection.data.companyPageNumber:=String:C10(oUser.companyDetail.pageNumber)