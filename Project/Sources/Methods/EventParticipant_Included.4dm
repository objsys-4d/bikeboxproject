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

C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
C_TEXT:C284($fullName; $eventName; $txtAttended)
For each ($oParticipant; $oParticipantSelection)
	$value:="."+$oParticipant.UUID
	If ($oParticipant.attended)
		$txtAttended:="checked"
	Else 
		$txtAttended:=""
	End if 
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



// UPDATE CONNECTION DATA...
oConnection.data.Participant:=$oParticipantSelection
oConnection.data.participantDataTable:=JSON Stringify:C1217($oDataTable)