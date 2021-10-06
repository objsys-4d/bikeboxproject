C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Person:15]; "personList"; "Select Donor")
If (OK=1)
	vtdonorName:=vSelName
	Form:C1466.donation.personID:=vSelID
End if 
