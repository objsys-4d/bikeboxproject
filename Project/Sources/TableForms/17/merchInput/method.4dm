Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle; vlMerchUUID)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vt_InputTitle:="Add New Merchandise"
				Form:C1466.merch:=ds:C1482.Merchandise.new()
				
			: (vtNavBtnTxt="Edit")
				C_OBJECT:C1216($oMerch)
				vt_InputTitle:="Merchandise Record"
				$oMerch:=ds:C1482.Merchandise.query("UUID = :1"; vlMerchUUID)
				Form:C1466.merch:=$oMerch[0]
				
		End case 
		
End case 