//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/21/21, 19:31:07
// ----------------------------------------------------
// Method: PersonObject_checkbox
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
If ($1#"")
	$value:=Substring:C12($1; 1; Position:C15("."; $1)-1)
	$fieldName:=Substring:C12($1; Position:C15("."; $1)+1)
	
	Case of 
		: ($fieldName="personActive")
			oConnection.data.personActive:=$value
			
		: ($fieldName="personValid")
			oConnection.data.personValid:=$value
			
		: ($fieldName="personDuplicate")
			oConnection.data.personDuplicate:=$value
			
	End case 
	
	
	
End if 