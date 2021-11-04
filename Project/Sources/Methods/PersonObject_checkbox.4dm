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
	If ($value="True")
		$valueText:="Yes"
	Else 
		$valueText:="No"
	End if 
	
	
	Case of 
		: ($fieldName="personActive")
			oConnection.data.personActive:=$value
			oConnection.data.Person.personObject.active:=$valueText
			
		: ($fieldName="personValid")
			oConnection.data.personValid:=$value
			oConnection.data.Person.personObject.valid:=$valueText
			
		: ($fieldName="personDuplicate")
			oConnection.data.personDuplicate:=$value
			oConnection.data.Person.personObject.duplicate:=$valueText
			
	End case 
	
	
	
End if 