//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/25/21, 21:45:25
// ----------------------------------------------------
// Method: Event_Recurring
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_BOOLEAN:C305($status)

If ($1#"")
	$value:=Substring:C12($1; 1; Position:C15("."; $1)-1)
	$fieldName:=Substring:C12($1; Position:C15("."; $1)+1)
	
	oConnection.data.Event.recurring:=($value="true")
	
End if 