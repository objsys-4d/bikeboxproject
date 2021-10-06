//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oPer)  // DONATION CONTACT
C_OBJECT:C1216($oPerson)  // DONATION SELECTION

$oPerson:=ds:C1482.Person.query("personID = :1"; oConnection.data.Donation.personID)

// *** DATATABLES ***
$oDataTable:=New collection:C1472

C_TEXT:C284($personName; $personAddr)
For each ($oPer; $oPerson)
	
	// ADD TO DATATABLES (JSON)
	$personName:=$oPer.lastName+", "+$oPer.firstName
	
	$personAddr:=$oPer.address1
	If ($oPer.city#"")
		$personAddr:=$personAddr+", "+$oPer.city
	End if 
	If ($oPer.state#"")
		$personAddr:=$personAddr+", "+$oPer.state
	End if 
	
	$oDataTable.push(New collection:C1472(""; $oPer.UUID; $personName; $personAddr; $oPer.phone))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.personDataTable:=JSON Stringify:C1217($oDataTable)