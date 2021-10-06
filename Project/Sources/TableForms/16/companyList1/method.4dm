Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vt_InputTitle)
		If (vt_InputTitle="")
			vt_InputTitle:="COMPANY LIST"
		End if 
		
		Form:C1466.companyList:=ds:C1482.Company.all()
		Form:C1466.companySearch:=""
		GOTO OBJECT:C206(*; "companySearch")
		
	: (Form event code:C388=On Unload:K2:2)
		vt_InputTitle:=""
End case 