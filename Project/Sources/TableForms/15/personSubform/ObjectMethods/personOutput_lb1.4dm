Case of 
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29)
		If (vbLoadFlag)
			vbLoadFlag:=False:C215
			vSelPosn:=Form:C1466.personOutput_lb.curPos
			CALL SUBFORM CONTAINER:C1086(On Load:K2:1)
		Else 
			vbLoadFlag:=True:C214
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		vb_OutPerson:=True:C214
		CALL SUBFORM CONTAINER:C1086(On Validate:K2:3)
		
End case 