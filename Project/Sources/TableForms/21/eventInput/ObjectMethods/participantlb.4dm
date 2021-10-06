Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Form:C1466.participantlb.curPos=0)
			OBJECT SET ENABLED:C1123(*; "bttnDel_Part"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "bttnDel_Part"; True:C214)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
End case 