//%attributes = {"shared":true}

// Project Method: Member_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [BB_Member]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oMember)  // Member RECORD
C_OBJECT:C1216($oMembers)  // Mebers SELECTION

C_TEXT:C284($txtMemberUUID)  // Member ID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="membersDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW MEMBER RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="members"))
	
	// LOAD THE MEMBERS SELECTION FOR PAGINATION CONTROL
	
	$oMembers:=Members_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('members-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oMember:=ds:C1482.BB_Member.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[BB_Member:15]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// MemberUUID PASSED AS URL PARAMETER?
		
		$txtMemberUUID:=Ltg_URL_GetParam("member")
		
		If ($txtMemberUUID="")
			
			$txtMemberUUID:=oConnection.record
		End if 
		
		// LOAD THE Member
		
		$oMember:=ds:C1482.BB_Member.get($txtMemberUUID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.membersDetail.pageNumber:=$oMember.indexOf($oMembers)+1
			oUser.membersDetail.pageCount:=$oMembers.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oMember:=$oMembers[oUser.membersDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Member:=$oMember  // Member

oConnection.data.membersPageCount:=String:C10(oUser.membersDetail.pageCount)
oConnection.data.membersPageNumber:=String:C10(oUser.membersDetail.pageNumber)

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE