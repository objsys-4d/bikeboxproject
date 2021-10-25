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
C_TEXT:C284($personName; $eventName; $txtAttended)
For each ($oPcp; $oParticipant)
	$value:="."+$oPcp.UUID
	If ($oPcp.attended)
		$txtAttended:="<input type='checkbox' checked='checked' onclick=\"ltgExecuteMethod('EventParticipant_Attended',this.checked+'"+$value+"')\"/>"
	Else 
		$txtAttended:="<input type='checkbox' onclick=\"ltgExecuteMethod('EventParticipant_Attended',this.checked+'"+$value+"')\"/>"
	End if 
	
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
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $eventDate; $personName; $txtAttended; String:C10($oPcp.amountDonated; "$###,###,##0.00"); ""))
			//$oDataTable.push(New collection(""; $oPcp.UUID; $eventDate; $personName; String($oPcp.amountDonated; "$###,###,##0.00"); ""))
			//$oDataTable.push(New collection(""; $oPcp.UUID; $eventDate; $personName; $oPcp.attended; String($oPcp.amountDonated; "$###,###,##0.00"); $oPcp.attended; ""))
			
		: (oConnection.referer="donation")
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $oPcp.dateEvent; $oPcp.eventName; $txtAttended; String:C10($oPcp.totalDonation; "$###,###,##0.00"); $oPcp.attended; ""))
			
		Else 
			$oPcpEvent:=$oPcp.Participant_Event
			If ($oPcpEvent=Null:C1517)
				$eventName:=""
				$eventDate:=!00-00-00!
			Else 
				$eventName:=$oPcpEvent.eventName
				$eventDate:=$oPcpEvent.dateEvent
			End if 
			
			$oDataTable.push(New collection:C1472(""; $oPcp.UUID; $eventDate; $eventName; $txtAttended; String:C10($oPcp.amountDonated; "$###,###,##0.00"); $oPcp.attended; ""))
	End case 
	
End for each 

If (oConnection.referer="event")
	$personName:=""
	C_TEXT:C284($personName)
	Ltg_JS_Send("ltgSelectDeleteOptions('.PersonIDquickAdd')")
	C_OBJECT:C1216($oPerson; $oPersonSelection)
	$oPersonSelection:=ds:C1482.Person.all().orderBy("lastName asc")
	Ltg_JS_Send("ltgSelectAddOption('.PersonIDquickAdd','0','"+$personName+"')")  //to clear
	For each ($oPerson; $oPersonSelection)
		$personName:=$oPerson.lastName+", "+$oPerson.firstName
		Ltg_JS_Send("ltgSelectAddOption('.PersonIDquickAdd','"+String:C10($oPerson.personID)+"','"+$personName+"')")
	End for each 
	Ltg_JS_Send("ltgSelectSetValue('.PersonIDquickAdd','0')")
End if 

// UPDATE CONNECTION DATA...
oConnection.data.Participant:=$oParticipant
oConnection.data.participantDataTable:=JSON Stringify:C1217($oDataTable)