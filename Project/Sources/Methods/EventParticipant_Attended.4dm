//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/22/21, 21:42:04
// ----------------------------------------------------
// Method: EventParticipant_Attended
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $UUID; $attendedText)  // participant UUID
C_OBJECT:C1216($status)
$UUID:=Substring:C12($1; 1; Position:C15("."; $1)-1)
$attendedText:=Substring:C12($1; Position:C15("."; $1)+1)

C_OBJECT:C1216($oParticipant)

$oParticipant:=ds:C1482.Participant.get($UUID)

If ($oParticipant#Null:C1517)
	
	If ($attendedText="false")  //current record is False, so the checkbox was checked
		$oParticipant.attended:=True:C214
	Else 
		//current record is True, so the check box was unchecked
		$oParticipant.attended:=False:C215
	End if 
	$status:=$oParticipant.save()
	If ($status.success)
		ParticipantEvent_QuickSelSave
	End if 
	
End if 
