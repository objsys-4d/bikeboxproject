//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 17:36:39
// ----------------------------------------------------
// Method: Event_objPulldown
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $eventID)
C_BOOLEAN:C305($2; $Add)
$eventID:=$1

If (Count parameters:C259=2)
	$Add:=$2
Else 
	$Add:=True:C214  //default
End if 

C_OBJECT:C1216($oEvn)
If ($eventID=0)
	$oEvn:=New object:C1471
	$oEvn.eventID:=0
Else 
	$oEvn:=ds:C1482.Event.query("eventID = :1"; $eventID).first()
	If ($oEvn=Null:C1517)
		$oEvn:=New object:C1471
		$oEvn.eventID:=0
	End if 
End if 
//Event Name pulldown
Ltg_JS_Send("ltgSelectDeleteOptions('Donation.event')")
C_OBJECT:C1216($oEvt; $oEvent)
$oEvent:=ds:C1482.Event.all().orderBy("eventName asc")
Ltg_JS_Send("ltgSelectAddOption('Donation.event','0','')")
If ($Add)
	Ltg_JS_Send("ltgSelectAddOption('Donation.event','-1','Add Event...')")  //to add
End if 
For each ($oEvt; $oEvent)
	Ltg_JS_Send("ltgSelectAddOption('Donation.event','"+String:C10($oEvt.eventID)+"','"+$oEvt.eventName+"')")
End for each 
Ltg_JS_Send("ltgSelectSetValue('Donation.event','"+String:C10($eventID)+"')")