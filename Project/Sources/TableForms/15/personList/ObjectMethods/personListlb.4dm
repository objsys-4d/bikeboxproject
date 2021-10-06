Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Form:C1466.personListlb.curPos=0)
			vblListSelect:=False:C215
		Else 
			vblListSelect:=True:C214
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		personList_Select
		
End case 