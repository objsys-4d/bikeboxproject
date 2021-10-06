C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Company:16]; "companyList"; "Select Company")
If (OK=1)
	vtcompanyName:=vSelName
	Form:C1466.person.companyID:=vSelID
End if 
