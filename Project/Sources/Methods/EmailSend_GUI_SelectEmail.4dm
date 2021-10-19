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
	GOTO OBJECT:C206(vEmailPtr->)  //(vtEmailSend_To)
	OBJECT SET VISIBLE:C603(*; "emailList_lb"; False:C215)
	vtKey:=""
	vEmailPtr->:=""  //vtEmailSend_To:=""
	vtEmailSend_Temp:=vtEmailSend_Temp+$selected+"; "
	vEmailPtr->:=vtEmailSend_Temp  //vtEmailSend_Temp+$selected+"; "
	
	POST KEY:C465(End key:K12:23)
End if 