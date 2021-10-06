//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/10/21, 18:58:14
// ----------------------------------------------------
// Method: bbobj_CityState
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)

Case of 
	: (This:C1470.city="") & (This:C1470.state="")
		$0:=""
		
	: (This:C1470.city#"") & (This:C1470.state="")
		$0:=This:C1470.city
		
	: (This:C1470.city="") & (This:C1470.state#"")
		$0:=This:C1470.state
		
	Else 
		$0:=This:C1470.city+", "+This:C1470.state
End case 
