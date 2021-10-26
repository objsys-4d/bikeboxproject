//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/22/21, 19:43:25
// ----------------------------------------------------
// Method: ParticipantEvent_QuickSelSave
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($eventID; $personID)
C_OBJECT:C1216($oParticipant; $oEvent)
C_OBJECT:C1216($status)

If (Count parameters:C259=2)
	C_LONGINT:C283($1; $2)
	$eventID:=$1
	$personID:=$2
	
	$oEvent:=ds:C1482.Event.query("eventID = :1"; $eventID)
	$oParticipant:=$oEvent.Event_Participant.query("personID = :1"; $personID)
	If ($oParticipant.length=0)
		$oParticipant:=ds:C1482.Participant.new()
		$oParticipant.personID:=$personID
		$oParticipant.eventID:=$eventID
		$status:=$oParticipant.save()
	Else 
		//alert
		
	End if 
End if 

Case of 
	: (oConnection.referer="person")
		oConnection.form:="person-detail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
		
		
	: (oConnection.referer="company")
		oConnection.form:="bbcompany-detail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
		
	: (oConnection.referer="event")
		oConnection.form:="events-detail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
End case 