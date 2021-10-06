Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (curPos=0)
			OBJECT SET ENABLED:C1123(*; "bttnDel_Event"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "bttnDel_Event"; True:C214)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
End case 