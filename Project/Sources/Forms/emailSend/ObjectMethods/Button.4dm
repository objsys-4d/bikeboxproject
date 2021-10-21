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
	
	If (Size of array:C274(atAttachments)#0)
		$attachmentsColl:=New collection:C1472
		ARRAY TO COLLECTION:C1563($attachmentsColl; atAttachments; "fileName"; atAttachmentsPath; "filePath")
	End if 
	
	$ProcID:=New process:C317("Email_Send"; 0; "Send Email"; vtEmailSend_To; vtEmailSend_Subject; vtEmailSend_Message; ""; ""; True:C214; $attachmentsColl)
	
	ACCEPT:C269
End if 