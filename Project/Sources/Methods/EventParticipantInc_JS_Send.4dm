//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 11/05/21, 16:52:08
// ----------------------------------------------------
// Method: EventParticipantInc_JS_Send
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oParticipant; $oPerson)  // DONATION CONTACT
C_OBJECT:C1216($oEvent; $oEventSelection; $oParticipantSelection)  // DONATION SELECTION

$oParticipantSelection:=ds:C1482.Participant.query("eventID = :1"; oConnection.data.Event.eventID)

// *** DATATABLES ***
$oDataTable:=New collection:C1472

C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
C_TEXT:C284($personName; $eventName; $txtAttended)
For each ($oParticipant; $oParticipantSelection)
	$value:="."+$oParticipant.UUID
	If ($oParticipant.participantID=0)
		$oCompany:=$oParticipant.Participant_Company
		$fullName:=$oCompany.companyName
	Else 
		$oPerson:=$oParticipant.Participant_Person
		$fullName:=$oPerson.fullName
	End if 
	
	// ADD TO DATATABLES (JSON)
	$oDataTable.push(New collection:C1472($oParticipant.UUID; ""; $txtAttended; $fullName; $txtAttended; ""))
	
End for each 

// CLEAR THE DATATABLE
Ltg_JS_Send("ltgObj('participant').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE
If ($oDataTable.length>0)
	Ltg_JS_Send("ltgObj('participant').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
End if 
