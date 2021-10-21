Case of 
	: (Form event code:C388=On Load:K2:1)
		C_COLLECTION:C1488(<>CollEmailList)
		C_TEXT:C284(vtKey; vtEmailSend_To2)
		C_BOOLEAN:C305(vblListDisplayed)
		vtKey:=""
		vblListDisplayed:=False:C215
		Output_lbInit("emailList_lb")
		Form:C1466.emailList_lb.data:=<>CollEmailList
		
		EmailSend_GUI_Init
		
		EmailSend_Attachments  //check if with attachments (most likely coming from FORWARD message)
		
		
End case 