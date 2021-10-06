Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vt_InputTitle:="Add New Company"
				Form:C1466.company:=ds:C1482.Company.new()
				
			: (vtNavBtnTxt="Edit")
				C_OBJECT:C1216($oComp)
				vt_InputTitle:="Company Record"
				$oComp:=ds:C1482.Company.query("UUID = :1"; vlCompanyUUID)
				Form:C1466.company:=$oComp[0]
				
		End case 
		
End case 