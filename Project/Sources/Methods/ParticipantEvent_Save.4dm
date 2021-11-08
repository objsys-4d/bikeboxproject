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
C_OBJECT:C1216($status)
C_BOOLEAN:C305($update)
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
If ($oParticipant.amountDonated#Num:C11(oConnection.data.Participant.amount))
	$update:=True:C214
	$oParticipant.amountDonated:=Num:C11(oConnection.data.Participant.amount)
End if 
$status:=$oParticipant.save()

If ($status.success) & ($update)
	$oEventC:=ds:C1482.Event.query("eventID = :1"; $oParticipant.eventID)
	$oEvent:=ds:C1482.Event.get($oEventC[0].UUID)
	$oParticipantSelection:=ds:C1482.Participant.query("eventID = :1"; $oParticipant.eventID)
	$oEvent.totalDonation:=$oParticipantSelection.sum("amountDonated")
	$oEvent.save()
	
	If (oConnection.referer="event")
		oConnection.data.Event.totalDonation:=$oEvent.totalDonation
	End if 
End if 



Case of 
	: (oConnection.referer="person")
		oConnection.form:="persondetail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
		
		
	: (oConnection.referer="company")
		oConnection.form:="companydetail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
		
	: (oConnection.referer="event")
		oConnection.form:="eventdetail.html"
		oConnection.action:="index"
		
		ParticipantInclude_DataTable
		oConnection.responseType:="javascript"
End case 