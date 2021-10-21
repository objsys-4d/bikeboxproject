Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		vEmailCurrentField:="to"
		vEmailPtr:=Self:C308
		vtEmailSend_Temp:=vEmailPtr->
		
	: (Form event code:C388=On After Keystroke:K2:26)
		EmailSend_TypeAhead(vEmailPtr)
		
	: (Form event code:C388=On Data Change:K2:15)
		
		vEmailPtr->:=EmailSend_CleanUp(vEmailPtr->)
		
End case 