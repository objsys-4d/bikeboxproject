Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbLoadFlag; vb_OutEvent)
		C_LONGINT:C283(vl_totalPart)
		vbLoadFlag:=True:C214
		vb_OutEvent:=False:C215
		vl_totalPart:=0
		Output_lbInit("eventOutput_lb")
		Form:C1466.eventOutput_lb.text:=""
		GOTO OBJECT:C206(*; "quickSearch")
End case 