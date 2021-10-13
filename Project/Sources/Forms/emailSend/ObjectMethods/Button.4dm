C_BOOLEAN:C305($Proceed)
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


If ($Proceed)
	C_BLOB:C604($attachmentBLOB)
	BLOB_VarsToBLOB(->$attachmentBLOB; ->atAttachments; ->atAttachmentsPath; ->atAttachmentsType; ->atAttachmentsBLOB)
	
	$ProcID:=New process:C317("Email_Send"; 0; "Send Email"; vtEmailSend_To; vtEmailSend_Subject; vtEmailSend_Message; ""; ""; True:C214; $attachmentBLOB)  //$attachmentsColl; vblMailAttach)
	
	ACCEPT:C269
End if 