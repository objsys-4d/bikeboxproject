//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 11/04/21, 21:07:50
// ----------------------------------------------------
// Method: PersonEvent_Included
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oParticipant; $oPerson)  // DONATION CONTACT
C_OBJECT:C1216($oEvent; $oEventSelection; $oParticipantSelection)  // DONATION SELECTION

//$oParticipantSelection:=ds.Participant.query("personID = :1"; oConnection.data.Person.personID)
//$oEventSelection:=$oParticipantSelection.Participant_Event
$oParticipantSelection:=oConnection.data.Event.Event_Participant

// *** DATATABLES ***
$oDataTable:=New collection:C1472
$dq:=Char:C90(Double quote:K15:41)

C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
C_TEXT:C284($personName; $eventName; $txtAttended)
For each ($oParticipant; $oParticipantSelection)
	$value:="."+$oParticipant.UUID
	If ($oParticipant.attended)
		$txtAttended:="checked"
	Else 
		$txtAttended:=""
	End if 
	$oPerson:=$oParticipant.Participant_Person
	
	
	// ADD TO DATATABLES (JSON)
	$oDataTable.push(New collection:C1472($oParticipant.UUID; ""; $txtAttended; $oPerson.fullName; $txtAttended; ""))
	
End for each 

// UPDATE CONNECTION DATA...
oConnection.data.Participant:=$oParticipantSelection
oConnection.data.participantDataTable:=JSON Stringify:C1217($oDataTable)