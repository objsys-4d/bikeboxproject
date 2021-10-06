Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbLoadFlag)
		vbLoadFlag:=True:C214
		Output_lbInit("merchOutput_lb")
		Form:C1466.merchOutput_lb.text:=""
		GOTO OBJECT:C206(*; "quickSearch")
End case 