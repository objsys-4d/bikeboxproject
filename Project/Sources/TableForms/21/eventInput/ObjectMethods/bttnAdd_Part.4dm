
C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID; vSelCoID)
GEN_Dlg_CenterWindow(->[Person:15]; "personList"; "Select Participant")
If (OK=1)
	C_OBJECT:C1216($oParticipant; $oPerson; $oPartList)
	
	//check if person is already in participant list
	$oPerson:=ds:C1482.Participant.query("eventID = :1 and personID = :2"; Form:C1466.event.eventID; vSelID)
	If ($oPerson.length=0)
		Form:C1466.event.save()  //save the header reacord first to establish the relation
		
		//save detail records
		$oParticipant:=ds:C1482.Participant.new()
		$oParticipant.eventID:=Form:C1466.event.eventID
		$oParticipant.personID:=vSelID
		$oParticipant.companyID:=vSelCoID
		$oParticipant.save()
		
		//refresh listbox data
		$oPartList:=ds:C1482.Event.get(vlEventUUID)
		Form:C1466.data_list:=$oPartList.Event_Participant
		Output_lbInit("participantlb")
	Else 
		ALERT:C41(vSelName+" is already in the list.")
	End if 
	
	
	
End if 
