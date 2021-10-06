C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Person:15]; "personList"; "Select Customer")
If (OK=1)
	vtCustomerName:=vSelName
	Form:C1466.order.personID:=vSelID
	
	CONFIRM:C162("Use saved Customer information?"; "Yes"; "No")
	If (OK=1)
		Form:C1466.order.phone1:=vSelPhone
		Form:C1466.order.email:=vSelEmail
		Form:C1466.order.address:=vSelAddr1
		Form:C1466.order.city:=vSelCity
		Form:C1466.order.state:=vSelState
		Form:C1466.order.zip:=vSelZip
	End if 
End if 
