//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/22/21, 21:09:47
// ----------------------------------------------------
// Method: EventParticipant_Delete
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)  // ITEM_ID

C_OBJECT:C1216($oParticipant)

$oParticipant:=ds:C1482.Participant.get($1)

If ($oParticipant#Null:C1517)
	
	$oParticipant.drop()
	
	//$oEvent:=ds.Event.get(oConnection.data.Event.UUID)
	//$oEventParticipants:=$oEvent.Event_Participant
	//$status:=$oEvent.save()
	
	//oConnection.form:="eventdetail.html"
	//oConnection.action:="index"
	
	ParticipantEvent_QuickSelSave
	
End if 
