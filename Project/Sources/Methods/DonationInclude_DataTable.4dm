//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 18:04:15
// ----------------------------------------------------
// Method: DonationInclude_DataTable
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($oDataTable)

C_OBJECT:C1216($oDonation)  // CURRENT ORDER ITEM
C_OBJECT:C1216($oDonationSelection)  // ORDER ITEM SELECTION

//C_OBJECT($oProduct)  // PRODUCT RECORD
C_TEXT:C284($txtActive; $eventName)

$oDonationSelection:=ds:C1482.Donation.query("personID = :1"; oConnection.data.Person.personID).orderBy("dateDonation asc")

$oDataTable:=New collection:C1472

For each ($oDonation; $oDonationSelection)
	
	// ADD TO DATATABLES (JSON)
	//If ($oDonationation.assigned)
	//$txtActive:="<input type='checkbox' disabled='disabled' checked='checked'/>"
	//Else 
	//$txtActive:="<input type='checkbox' disabled='disabled'/>"
	//End if 
	$oDonationEvent:=$oDonation.Donation_Event
	If ($oDonationEvent=Null:C1517)
		$eventName:=""
	Else 
		$eventName:=$oDonationEvent.eventName
	End if 
	
	$oDataTable.push(New collection:C1472(""; $oDonation.UUID; $oDonation.dateDonation; $eventName; String:C10($oDonation.amount; "$###,###,##0.00")))
	
End for each 

// CLEAR THE ORDER ITEMS DATATABLE

Ltg_JS_Send("ltgObj('donation').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE

If ($oDataTable.length>0)
	
	Ltg_JS_Send("ltgObj('donation').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
	
End if 

