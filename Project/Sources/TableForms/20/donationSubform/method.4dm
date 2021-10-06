Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbLoadFlag)
		C_REAL:C285(vrTotalAmt)
		C_LONGINT:C283(vlPartCount)
		ARRAY TEXT:C222(tbDonationsTab; 2)
		vbLoadFlag:=True:C214
		Output_lbInit("personOutput_lb")
		Output_lbInit("eventOutput_lb")
		
		Form:C1466.personOutput_lb.text:=""
		Form:C1466.eventOutput_lb.text:=""
		GOTO OBJECT:C206(*; "quickSearch")
		vrTotalAmt:=0
		vlPartCount:=0
End case 