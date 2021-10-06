//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oDon)  // DONATION CONTACT
C_OBJECT:C1216($oDonation)  // DONATION SELECTION

Case of 
	: (oConnection.referer="person")
		$oDonation:=ds:C1482.Donation.query("personID = :1"; oConnection.data.Person.personID).orderBy("dateDonation asc")
		
	: (oConnection.referer="event")
		//$oDonation:=ds.Donation.query("event = :1"; oConnection.data.Person.personID)
		
End case 
// *** DATATABLES ***

$oDataTable:=New collection:C1472

C_OBJECT:C1216($oDonPerson; $oDonEvent)
C_TEXT:C284($personName; $eventName)
For each ($oDon; $oDonation)
	
	// ADD TO DATATABLES (JSON)
	//$oDonPerson:=$oDon.Donation_Person
	$oDonEvent:=$oDon.Donation_Event
	//If ($oDonPerson=Null)
	//$personName:=""
	//Else 
	//$personName:=$oDonPerson.lastName+", "+$oDonPerson.firstName
	//End if 
	
	If ($oDonEvent=Null:C1517)
		$eventName:=""
	Else 
		$eventName:=$oDonEvent.eventName
	End if 
	
	$oDataTable.push(New collection:C1472(""; $oDon.UUID; $oDon.dateDonation; $eventName; String:C10($oDon.amount; "$###,###,##0.00")))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.donationDataTable:=JSON Stringify:C1217($oDataTable)