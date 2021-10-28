//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 20:09:47
// ----------------------------------------------------
// Method: ParticipantEvent_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($oStatus; $oPerson; $oParticipant; $oSelected)

If (oConnection.selected.length>0)
	
	For each ($oSelected; oConnection.selected)
		
		$personUUID:=$oSelected.record
		$oPerson:=ds:C1482.Person.get($personUUID)
		
		$oParticipant:=ds:C1482.Participant.query("eventID = :1 and personID = :2"; oConnection.data.Event.eventID; $oPerson.personID)
		If ($oParticipant.length=0)
			$oParticipant:=ds:C1482.Participant.new()
			$oParticipant.personID:=$oPerson.personID
			$oParticipant.eventID:=oConnection.data.Event.eventID
			$oStatus:=$oParticipant.save()
		End if 
		
	End for each 
	
	// CLEAR SELECTION
	oConnection.selected:=New collection:C1472
	
	//refresh the inlcuded list
	ParticipantEvent_QuickSelSave
	
End if 