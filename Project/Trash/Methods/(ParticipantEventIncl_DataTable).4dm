//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 18:57:07
// ----------------------------------------------------
// Method: ParticipantEventIncl_DataTable
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_COLLECTION:C1488($oDataTable)

C_OBJECT:C1216($oEvent)  // CURRENT ORDER ITEM
C_OBJECT:C1216($oEventSelection)  // ORDER ITEM SELECTION

C_OBJECT:C1216($oParticipantSelection)

//C_OBJECT($oProduct)  // PRODUCT RECORD
C_TEXT:C284($txtActive; $eventName)

$oParticipantSelection:=ds:C1482.Participant.query("personID = :1"; oConnection.data.Person.personID)

$oDataTable:=New collection:C1472

For each ($oEvent; $oEventSelection)
	
	// ADD TO DATATABLES (JSON)
	//If ($oEventation.assigned)
	//$txtActive:="<input type='checkbox' disabled='disabled' checked='checked'/>"
	//Else 
	//$txtActive:="<input type='checkbox' disabled='disabled'/>"
	//End if 
	$oEventEvent:=$oEvent.donation_Event
	If ($oEventEvent=Null:C1517)
		$eventName:=""
	Else 
		$eventName:=$oEventEvent.eventName
	End if 
	
	$oDataTable.push(New collection:C1472(""; $oEvent.UUID; $oEvent.dateEvent; $oEvent.eventName; String:C10($oEvent.totalDonation; "$###, ###, ###, ##0.00")))
	
End for each 

// CLEAR THE ORDER ITEMS DATATABLE

Ltg_JS_Send("ltgObj('donation').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE

If ($oDataTable.length>0)
	
	Ltg_JS_Send("ltgObj('donation').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
	
End if 
