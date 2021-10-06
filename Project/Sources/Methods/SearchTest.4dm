//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/21/21, 17:43:12
// ----------------------------------------------------
// Method: SearchTest
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($person : Object; $dataClassName : Text)
var $dataStore; $duplicates : Object

$person:=ds:C1482.Person.all().first()  //get an entity
$dataStore:=$person.getDataClass().getDataStore()
$entitySel:=$dataStore[$dataClassName].query("firstName = :1"; $person.firstName)