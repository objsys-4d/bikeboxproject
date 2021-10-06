Case of 
	: (Form event code:C388=On Load:K2:1)
		C_DATE:C307(vdDonationDate)
		C_REAL:C285(vrAmount)
		C_TEXT:C284(vDlgAction)
		
		vdDonationDate:=Current date:C33(*)
		vrAmount:=0
		
End case 