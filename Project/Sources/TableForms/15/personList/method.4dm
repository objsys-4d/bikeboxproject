Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vt_ListTitle)
		C_BOOLEAN:C305(vblListSelect)
		If (vt_ListTitle="")
			vt_ListTitle:="PERSON LIST"
		End if 
		
		vblListSelect:=False:C215
		
		Form:C1466.data_list:=ds:C1482.Person.all()
		Output_lbInit("personListlb")
		
		Form:C1466.personSearch:=""
		GOTO OBJECT:C206(*; "personSearch")
		
	: (Form event code:C388=On Unload:K2:2)
		vt_ListTitle:=""
End case 