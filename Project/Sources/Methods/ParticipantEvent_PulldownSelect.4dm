//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 11/05/21, 00:27:48
// ----------------------------------------------------
// Method: ParticipantEvent_PulldownSelect
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