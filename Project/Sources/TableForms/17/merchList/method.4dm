Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vt_InputTitle)
		C_LONGINT:C283(vSelStock)
		C_REAL:C285(vSelPrice)
		C_BOOLEAN:C305(vblListSelect)
		If (vt_InputTitle="")
			vt_InputTitle:="MERCHANDISE LIST"
		End if 
		
		vblListSelect:=False:C215
		
		Form:C1466.data_list:=ds:C1482.Merchandise.all()
		Output_lbInit("merchListlb")
		
		Form:C1466.merchSearch:=""
		GOTO OBJECT:C206(*; "merchSearch")
		
	: (Form event code:C388=On Unload:K2:2)
		vt_InputTitle:=""
End case 