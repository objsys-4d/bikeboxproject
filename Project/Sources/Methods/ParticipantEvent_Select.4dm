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
C_OBJECT:C1216($oEvent)
C_TEXT:C284($eventDate)

$oEvent:=ds:C1482.Event.query("eventID = :1"; Num:C11(oConnection.data.Donation.event))

$eventDate:=String:C10($oEvent[0].dateEvent)
oConnection.data.Participant.date:=$eventDate
oConnection.data.Participant.eventID:=$oEvent[0].eventID