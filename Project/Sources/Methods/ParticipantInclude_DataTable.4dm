//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 21:12:05
// ----------------------------------------------------
// Method: ParticipantInclude_DataTable
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($oDataTable)

C_OBJECT:C1216($oParticipant)  // CURRENT ORDER ITEM
C_OBJECT:C1216($oParticipantSelection)  // ORDER ITEM SELECTION

//C_OBJECT($oProduct)  // PRODUCT RECORD
C_TEXT:C284($txtActive; $eventName)

Case of 
	: (oConnection.referer="person")
		$oParticipantSelection:=ds:C1482.Participant.query("personID = :1"; oConnection.data.Person.personID)
		
	: (oConnection.referer="company")
		$oParticipantSelection:=ds:C1482.Participant.query("companyID = :1"; oConnection.data.Company.companyID)
		
	: (oConnection.referer="event")
		$oParticipantSelection:=ds:C1482.Participant.query("eventID = :1"; oConnection.data.Event.eventID)
		
End case 

$oDataTable:=New collection:C1472
C_OBJECT:C1216($oPcpPerson; $oPcpEvent)
For each ($oParticipant; $oParticipantSelection)
	
	
	$oPcpEvent:=$oParticipant.Participant_Event
	If ($oPcpEvent=Null:C1517)
		$eventName:=""
		$eventDate:=!00-00-00!
	Else 
		If (oConnection.referer="event")
			$oPcpPerson:=$oParticipant.Participant_Person
			If ($oPcpPerson=Null:C1517)
				$eventName:=""
			Else 
				$eventName:=$oPcpPerson.lastName+", "+$oPcpPerson.firstName
			End if 
		Else 
			$eventName:=$oPcpEvent.eventName
		End if 
		$eventDate:=$oPcpEvent.dateEvent
	End if 
	
	
	$oDataTable.push(New collection:C1472(""; $oParticipant.UUID; $eventDate; $eventName; String:C10($oParticipant.amountDonated; "$###,###,##0.00")))
	
End for each 

// CLEAR THE ORDER ITEMS DATATABLE

Ltg_JS_Send("ltgObj('participant').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE

If ($oDataTable.length>0)
	
	Ltg_JS_Send("ltgObj('participant').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
	
End if 
