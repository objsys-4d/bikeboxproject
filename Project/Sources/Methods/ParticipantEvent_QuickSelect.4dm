//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/22/21, 19:09:49
// ----------------------------------------------------
// Method: ParticipantEvent_QuickSelect
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (oConnection.data.PersonIDquickAdd="0")
	//do nothing
Else 
	C_OBJECT:C1216($oPerson)
	$personID:=Num:C11(oConnection.data.PersonIDquickAdd)
	$eventID:=Num:C11(oConnection.data.Event.eventID)
	$oPerson:=ds:C1482.Person.query("personID = :1"; $personID)
	If ($oPerson.length=1)
		ParticipantEvent_QuickSelSave($eventID; $personID)
	End if 
End if 

Ltg_JS_Send("ltgSelectSetValue('.PersonIDquickAdd').value('0')")
