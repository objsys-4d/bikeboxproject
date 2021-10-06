C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Event:21]; "eventList"; "Person -> Add to Event")
If (OK=1)
	C_OBJECT:C1216($oParticipant; $oPart)
	
	Form:C1466.person.save()
	
	$oPart:=ds:C1482.Participant.query("eventID = :1 and personID = :2"; vSelID; Form:C1466.person.personID)
	If ($oPart.length=0)
		$oParticipant:=ds:C1482.Participant.new()
		$oParticipant.eventID:=vSelID
		$oParticipant.personID:=Form:C1466.person.personID
		$oParticipant.save()
		
		//refresh listbox data
		$oPerson:=ds:C1482.Person.get(vlPersonUUID)
		Form:C1466.data_list:=$oPerson.Person_Participant
		Output_lbInit("participantlb")
	Else 
		ALERT:C41(Form:C1466.person.lastName+", "+Form:C1466.person.firstName+" is already a participant of "+vSelName+".")
	End if 
End if 
