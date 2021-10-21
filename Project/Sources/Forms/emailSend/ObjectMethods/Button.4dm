C_BOOLEAN:C305($Proceed)
C_TEXT:C284(vtmessageHeader)
$cr:=Char:C90(13)
Case of 
	: (vtEmailSend_To="")
		ALERT:C41("There is no email recipient.")
		GOTO OBJECT:C206(vtEmailSend_To)
		
	: (vtEmailSend_Subject="")
		CONFIRM:C162("Send email without subject?"; "Yes"; "No")
		If (OK=1)
			$Proceed:=True:C214
		End if 
		
	Else 
		$Proceed:=True:C214
End case 

//build htmlMessage
If (vtEmailSend_Type="new")
	vtEmailSend_Message:="<html><body>"+vtEmailSend_Message+"</body></html>"
Else 
	vtEmailSend_Message:="<html><body>"+vtEmailSend_Message+vtmessageHeader+"</body></html>"+vtorigMessage
End if 

//Case of 
//: (vtEmailSend_Type="forward")
//$messageHeader:="<br>--------Forwarded message-------<br>From: "+voMailSendInfo.from+\
"<br>Date: "+voMailSendInfo.dateInfo+"<br>Subject: "+voMailSendInfo.subject+"<br>To: "+voMailSendInfo.to+"<br><br>"

//vtEmailSend_Message:="<html><body>"+vtEmailSend_Message+"<br>"+$messageHeader+"</body></html>"+vtorigMessage

//: (vtEmailSend_Type="reply@")
//$messageHeader:="<br>--------Original message-------<br>From: "+voMailSendInfo.from+\
"<br>Date: "+voMailSendInfo.dateInfo+"<br>Subject: "+voMailSendInfo.subject+"<br>To: "+voMailSendInfo.to+"<br><br>"

//vtEmailSend_Message:="<html><body>"+vtEmailSend_Message+"<br>"+$messageHeader+"</body></html>"+vtorigMessage


//: (vtEmailSend_Type="new")
//vtEmailSend_Message:="<html><body>"+vtEmailSend_Message+"</body></html>"
//End case 

If ($Proceed)
	C_BLOB:C604($attachmentBLOB)
	BLOB_VarsToBLOB(->$attachmentBLOB; ->atAttachments; ->atAttachmentsPath; ->atAttachmentsType; ->atAttachmentsBLOB)
	
	$ProcID:=New process:C317("Email_Send"; 0; "Send Email"; vtEmailSend_To; vtEmailSend_Subject; vtEmailSend_Message; ""; ""; True:C214; $attachmentBLOB)  //$attachmentsColl; vblMailAttach)
	
	ACCEPT:C269
End if 