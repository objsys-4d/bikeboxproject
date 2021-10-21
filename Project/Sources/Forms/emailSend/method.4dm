Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtEmailSend_To; vtEmailSend_CC; vtEmailSend_Subject)
		
		ARRAY BOOLEAN:C223(Attachmentslb; 0)
		ARRAY TEXT:C222(atAttachments; 0)
		
		OBJECT SET ENABLED:C1123(btAttach_Rem; False:C215)
End case 