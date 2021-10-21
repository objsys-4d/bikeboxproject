//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/13/21, 21:03:18
// ----------------------------------------------------
// Method: EmailSend_GUI_Init
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vtEmailSend_To; vtEmailSend_CC; vtEmailSend_Subject; vtEmailSend_Message; vtEmailSend_Type)
C_OBJECT:C1216(voMailSendInfo)

OBJECT SET ENABLED:C1123(btAttach_Rem; False:C215)

If (OB Is empty:C1297(voMailSendInfo))
	vtEmailSend_Type:="new"
Else 
	vtEmailSend_Type:=voMailSendInfo.type
End if 

vtEmailSend_Message:=""
If (vtEmailSend_Type="new")
	vtEmailSend_To:=""
	vtEmailSend_CC:=""
	vtEmailSend_Subject:=""
	vtEmailSend_BodyType:=""
	OBJECT SET VISIBLE:C603(*; "emailHTML_@"; False:C215)
	OBJECT SET COORDINATES:C1248(vtEmailSend_Message; 27; 153; 661; 781)
Else 
	vtEmailSend_To:=voMailSendInfo.recipient
	vtEmailSend_CC:=voMailSendInfo.cc
	vtEmailSend_Subject:="Re: "+voMailSendInfo.subject
	vtEmailSend_Message:=voMailSendInfo.message
	vtEmailSend_BodyType:=voMailSendInfo.bodyType
End if 

If (vtEmailSend_BodyType="text/html")
	$origMessage:=vtEmailSend_Message
	vtEmailSend_Message:=""
Else 
	$origMessage:="<html><body>"+vtEmailSend_Message+"</body></html>"
End if 
WA SET PAGE CONTENT:C1037(*; "emailHTML_WA"; $origMessage; "file:///")

If (vtEmailSend_Type="forward") | (vtEmailSend_Type="new")
	GOTO OBJECT:C206(vtEmailSend_To)
Else 
	GOTO OBJECT:C206(vtEmailSend_Message)
End if 