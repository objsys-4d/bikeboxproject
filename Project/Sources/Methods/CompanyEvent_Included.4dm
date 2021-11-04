//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 11/04/21, 22:34:35
// ----------------------------------------------------
// Method: CompanyEvent_Included
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oParticipant; $oPerson)  // DONATION CONTACT
C_OBJECT:C1216($oEvent; $oEventSelection; $oParticipantSelection)  // DONATION SELECTION

$oParticipantSelection:=ds:C1482.Participant.query("companyID = :1"; oConnection.data.Company.companyID)
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

// UPDATE CONNECTION DATA...
oConnection.data.Event:=$oEventSelection
oConnection.data.participantDataTable:=JSON Stringify:C1217($oDataTable)