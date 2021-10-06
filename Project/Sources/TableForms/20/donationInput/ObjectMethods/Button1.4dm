C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Event:21]; "eventList"; "Person -> Add to Event")
If (OK=1)
	Form:C1466.donation.eventID:=vSelID
	vtEventName:=vSelName
End if 
