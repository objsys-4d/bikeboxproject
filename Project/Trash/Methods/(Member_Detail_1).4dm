//%attributes = {"shared":true}

// Project Method: Company_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [learner]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oLearn)  // Learner RECORD
C_OBJECT:C1216($oLearner)  // Learner SELECTION

C_TEXT:C284($txtLearn_ID)  // Learner UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="memberDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW LEARNER RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="learner"))
	
	// LOAD THE learner SELECTION FOR PAGINATION CONTROL
	
	$oLearner:=Members_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('members-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oLearn:=ds:C1482.BB_Member.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[BB_Member:15]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// COMPANY_ID PASSED AS URL PARAMETER?
		
		$txtLearn_ID:=Ltg_URL_GetParam("member")
		
		If ($txtLearn_ID="")
			
			$txtLearn_ID:=oConnection.record
		End if 
		
		// LOAD THE LEARNER
		
		$oLearn:=ds:C1482.BB_Member.get($txtLearn_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.membersDetail.pageNumber:=$oLearn.indexOf($oLearner)+1
			oUser.membersDetail.pageCount:=$oLearner.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oLearn:=$oLearner[oUser.learnerDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Member:=$oLearn  // COMPANY

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.membersPageCount:=String:C10(oUser.memberDetail.pageCount)
oConnection.data.membersPageNumber:=String:C10(oUser.memberDetail.pageNumber)