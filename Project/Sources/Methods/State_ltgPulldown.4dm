//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/06/21, 19:59:39
// ----------------------------------------------------
// Method: State_ltgPulldown
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $navpage; $webObjID)
C_TEXT:C284($2; $selectedState)
$navpage:=$1
$selectedState:=$2

Case of 
	: ($navpage="person")
		$webObjID:="Person.state"
		
	: ($navpage="company")
		$webObjID:="Company.state"
		
	: ($navpage="order")
		$webObjID:="Order.state"
		
End case 

Ltg_JS_Send("ltgSelectDeleteOptions('"+$webObjID+"')")
Ltg_JS_Send("ltgSelectAddOption('"+$webObjID+"','','')")
For ($s; 1; Size of array:C274(<>atUSStates))
	Ltg_JS_Send("ltgSelectAddOption('"+$webObjID+"','"+<>atUSStates{$s}+"','"+<>atUSStates{$s}+"')")
End for 
Ltg_JS_Send("ltgSelectSetValue('"+$webObjID+"','"+$selectedState+"')")