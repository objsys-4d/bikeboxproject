//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oPcp; $oPerson)  // DONATION CONTACT
C_OBJECT:C1216($oParticipant)  // DONATION SELECTION

Case of 
	: (oConnection.referer="person")
		$oParticipant:=ds:C1482.Participant.query("personID = :1"; oConnection.data.Person.personID)
		
	: (oConnection.referer="company")
		$oParticipant:=ds:C1482.Participant.query("companyID = :1"; oConnection.data.Company.companyID)
		
	: (oConnection.referer="event")
		$oParticipant:=oConnection.data.Event.Event_Participant
		
	: (oConnection.referer="donation")
		$oParticipant:=ds:C1482.Event.query("eventID = :1"; oConnection.data.Donation.eventID)
		//$oParticipant:=oConnection.data.Donation.Donation_Event
		
End case 
// *** DATATABLES ***
$oDataTable:=New collection:C1472

C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
C_TEXT:C284($personName; $eventName)
For each ($oPcp; $oParticipant)
	
	// ADD TO DATATABLES (JSON)
	Case of 
		: (oConnection.referer="event")
			$eventDate:=oConnection.data.Event.dateEvent
			$oPcpEvent:=$oPcp.Participant_Person
			If ($oPcpEvent=Null:C1517)
				$personName:=""
			Else 
				$personName:=$oPcpEvent.lastName+", "+$oPcpEvent.firstName
			End if 
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $eventDate; $personName; String:C10($oPcp.amountDonated; "$###,###,##0.00")))
			
		: (oConnection.referer="donation")
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $oPcp.dateEvent; $oPcp.eventName; String:C10($oPcp.totalDonation; "$###,###,##0.00")))
			
		Else 
			$oPcpEvent:=$oPcp.Participant_Event
			If ($oPcpEvent=Null:C1517)
				$eventName:=""
				$eventDate:=!00-00-00!
			Else 
				$eventName:=$oPcpEvent.eventName
				$eventDate:=$oPcpEvent.dateEvent
			End if 
			
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $eventDate; $eventName; String:C10($oPcp.amountDonated; "$###,###,##0.00")))
	End case 
	
End for each 

// UPDATE CONNECTION DATA...
oConnection.data.Participant:=$oParticipant
oConnection.data.participantDataTable:=JSON Stringify:C1217($oDataTable)