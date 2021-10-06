//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 20:47:43
// ----------------------------------------------------
// Method: ParticipantEvent_Save
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($oParticipant)
C_OBJECT:C1216($success)

$oParticipant:=ds:C1482.Participant.get(oConnection.data.Participant.UUID)

If ($oParticipant=Null:C1517)
	$oParticipant:=ds:C1482.Participant.new()
	If (Num:C11(oConnection.data.Participant.personNamepd)#0)
		$oParticipant.personID:=oConnection.data.Participant.personNamepd
	Else 
		$oParticipant.personID:=oConnection.data.Participant.personID
	End if 
	$oParticipant.companyID:=oConnection.data.Participant.companyID
End if 

$oParticipant.eventID:=Num:C11(oConnection.data.Participant.eventID)
$oParticipant.amountDonated:=Num:C11(oConnection.data.Participant.amount)
$success:=$oParticipant.save()


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