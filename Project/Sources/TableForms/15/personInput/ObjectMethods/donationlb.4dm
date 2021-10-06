Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Form:C1466.donationlb.curPos=0)
			OBJECT SET ENABLED:C1123(*; "bttnDel_Donation"; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*; "bttnDel_Donation"; True:C214)
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
End case 