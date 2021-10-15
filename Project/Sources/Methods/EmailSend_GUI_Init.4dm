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

C_TEXT:C284(vtEmailSend_To; vtEmailSend_To2; vtEmailSend_CC; vtEmailSend_Subject; vtEmailSend_Message; vtEmailSend_Type; vtorigMessage; vtmessageHeader)
C_OBJECT:C1216(voMailSendInfo)

OBJECT SET ENABLED:C1123(btAttach_Rem; False:C215)
$cr:=Char:C90(13)
If (OB Is empty:C1297(voMailSendInfo))
	vtEmailSend_Type:="new"
Else 
	vtEmailSend_Type:=voMailSendInfo.type
End if 

vtEmailSend_Message:=""
If (vtEmailSend_Type="new")
	vtEmailSend_To:=""
	vtEmailSend_To2:=""
	vtEmailSend_CC:=""
	vtEmailSend_Subject:=""
	vtEmailSend_BodyType:=""
	OBJECT SET VISIBLE:C603(*; "emailHTML_@"; False:C215)
	OBJECT SET COORDINATES:C1248(vtEmailSend_Message; 27; 153; 661; 781)
Else 
	vtEmailSend_To:=voMailSendInfo.recipient
	vtEmailSend_CC:=voMailSendInfo.cc
	vtEmailSend_To2:=vtEmailSend_To
	If (vtEmailSend_Type="forward")
		vtEmailSend_Subject:="Fwd: "+voMailSendInfo.subject
	Else 
		vtEmailSend_Subject:="Re: "+voMailSendInfo.subject
	End if 
	vtEmailSend_Message:=voMailSendInfo.message
	vtEmailSend_BodyType:=voMailSendInfo.bodyType
	
	$buildMailTo:=Replace string:C233(voMailSendInfo.to; "<"; "&lt;")
	$buildMailTo:=Replace string:C233($buildMailTo; ">"; "&gt;")
	$buildMailFrom:=Replace string:C233(voMailSendInfo.from; "<"; "&lt;")
	$buildMailFrom:=Replace string:C233($buildMailFrom; ">"; "&gt;")
	Case of 
		: (vtEmailSend_Type="forward")
			vtmessageHeader:="<br/><br/>--------Forwarded message-------<br/>From: "+$buildMailFrom+\
				"<br/>Date: "+voMailSendInfo.dateInfo+"<br/>Subject: "+voMailSendInfo.subject+"<br/>To: "+$buildMailTo+"<br/><br/>"
			
		: (vtEmailSend_Type="reply@")
			vtmessageHeader:="<br/><br/>--------Original message-------<br/>From: "+$buildMailFrom+\
				"<br/>Date: "+voMailSendInfo.dateInfo+"<br/>Subject: "+voMailSendInfo.subject+"<br/>To: "+$buildMailTo+"<br/><br/>"
			
	End case 
	If (vtEmailSend_BodyType="text/html")
		vtorigMessage:=vtEmailSend_Message
		vtEmailSend_Message:=""
	Else 
		vtorigMessage:="<html><body>"+vtEmailSend_Message+"</body></html>"
	End if 
	WA SET PAGE CONTENT:C1037(*; "emailHTML_WA"; vtorigMessage; "file:///")
End if 


If (vtEmailSend_Type="forward") | (vtEmailSend_Type="new")
	GOTO OBJECT:C206(vtEmailSend_To)
Else 
	GOTO OBJECT:C206(vtEmailSend_Message)
End if 

ARRAY TEXT:C222(atEmailSendTo; 0)  //will be used to hold email address
