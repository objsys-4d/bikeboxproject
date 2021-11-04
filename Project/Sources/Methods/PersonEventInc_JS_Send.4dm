//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 11/04/21, 23:18:47
// ----------------------------------------------------
// Method: PersonEventInc_JS_Send
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oParticipant; $oPerson)  // DONATION CONTACT
C_OBJECT:C1216($oEvent; $oEventSelection; $oParticipantSelection)  // DONATION SELECTION

$oParticipantSelection:=ds:C1482.Participant.query("personID = :1"; oConnection.data.Person.personID)
$oEventSelection:=$oParticipantSelection.Participant_Event

// *** DATATABLES ***
$oDataTable:=New collection:C1472
$dq:=Char:C90(Double quote:K15:41)

C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
C_TEXT:C284($personName; $eventName; $txtAttended)
For each ($oEvent; $oEventSelection)
	
	// ADD TO DATATABLES (JSON)
	$oParticipant:=$oParticipantSelection.query("eventID = :1"; $oEvent.eventID)
	If ($oParticipant#Null:C1517)
		If ($oParticipant[0].attended)
			$txtAttended:="checked"
		Else 
			$txtAttended:=""
		End if 
	End if 
	
	$oDataTable.push(New collection:C1472($oParticipant[0].UUID; ""; $txtAttended; $oEvent.dateEvent; $oEvent.eventName; $txtAttended; ""))
	
End for each 

// CLEAR THE DATATABLE
Ltg_JS_Send("ltgObj('participant').dataTable().fnClearTable()")

// UPDATE THE EVENT LIST DATATABLE
If ($oDataTable.length>0)
	Ltg_JS_Send("ltgObj('participant').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
End if 