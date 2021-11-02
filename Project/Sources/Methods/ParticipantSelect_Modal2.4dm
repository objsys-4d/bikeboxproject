//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 00:06:17
// ----------------------------------------------------
// Method: DonationPerson_Modal
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($oEventRec; $oPersonSelection; $oPerson)
C_COLLECTION:C1488($oDataTable)

//$oEventRec:=ds.Event.get(oConnection.data.Event.UUID)
$oPersonSelection:=ds:C1482.Person.all()  //$oEventRec.Event_Participant

C_TEXT:C284($personName)
$oDataTable:=New collection:C1472
For each ($oPerson; $oPersonSelection)
	
	$oDataTable.push(New collection:C1472(""; ""; $oPerson.fullName))
	
End for each 

// CLEAR THE DATATABLE
Ltg_JS_Send("ltgObj('participantSelect').dataTable().fnClearTable()")

// UPDATE THE ITEMS DATATABLE
If ($oDataTable.length>0)
	Ltg_JS_Send("ltgObj('participantSelect').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
End if 

//oConnection.data.Person:=$oPersonSelection
//oConnection.data.personDataTable:=JSON Stringify($oDataTable)
