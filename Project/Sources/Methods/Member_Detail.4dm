//%attributes = {"shared":true}

// Project Method: Company_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [course]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oMem)  //Course record
C_OBJECT:C1216($oMember)  // Course SELECTION

C_TEXT:C284($txtMem_ID)  // course ID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="memberDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW COURSE RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="member"))
	
	// LOAD THE course SELECTION FOR PAGINATION CONTROL
	
	$oMember:=Member_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('member-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oMem:=ds:C1482.Member.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Course:11]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// Course UUID PASSED AS URL PARAMETER?
		
		$txtMem_ID:=Ltg_URL_GetParam("member")  //course UUID
		
		If ($txtMem_ID="")
			
			$txtMem_ID:=oConnection.record
		End if 
		
		// LOAD THE COURSE
		
		$oMem:=ds:C1482.Member.get($txtMem_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.memberDetail.pageNumber:=$oMem.indexOf($oMember)+1
			oUser.memberDetail.pageCount:=$oMember.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oMem:=$oMember[oUser.memberDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Member:=$oMem  // course
oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE
oConnection.data.memberPageCount:=String:C10(oUser.memberDetail.pageCount)
oConnection.data.memberPageNumber:=String:C10(oUser.memberDetail.pageNumber)