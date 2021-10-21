//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/15/21, 21:00:29
// ----------------------------------------------------
// Method: EmailSend_GUI_SelectEmail
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($selected)
$selected:=Form:C1466.emailList_lb.data[Form:C1466.emailList_lb.currentPosition-1]

If ($selected#"")
	vblListDisplayed:=False:C215
	If (Find in array:C230(atEmailSendTo; $selected)=-1)
		APPEND TO ARRAY:C911(atEmailSendTo; $selected)
	End if 
	GOTO OBJECT:C206(vtEmailSend_To)
	OBJECT SET VISIBLE:C603(*; "emailList_lb"; False:C215)
	vtKey:=""
	vtEmailSend_To:=""
	For ($i; 1; Size of array:C274(atEmailSendTo))
		vtEmailSend_To:=vtEmailSend_To+atEmailSendTo{$i}+"; "
	End for 
	POST KEY:C465(End key:K12:23)
End if 