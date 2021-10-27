//%attributes = {}
TRACE:C157
$value:="12345"
$dq:=Char:C90(Double quote:K15:41)
If ($oParticipant.attended)
	$txtAttended:="<input type='checkbox' checked='checked' onclick="+$dq+"ltgExecuteMethod('EventParticipant_Attended',this.checked+'"+$value+"')"+$dq+"/>"
Else 
	$txtAttended:="<input type='checkbox' onclick="+$dq+"ltgExecuteMethod('EventParticipant_Attended',this.checked+'"+$value+"')"+$dq+"/>"
End if 