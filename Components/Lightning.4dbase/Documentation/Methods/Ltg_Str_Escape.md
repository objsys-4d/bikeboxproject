<!--
    Ltg_Str_Escape ( source [text] ) -> target [text]

    This method is used to escape single quotes, carriage returns, and line feeds when sending text to the client.
-->

# Ltg_Str_Escape

*Ltg_Str_Escape* ( _source_ [text] ) -> target [text]

## Description

Escapes single quotes, carriage returns, and line feeds when sending text to the client. 

## Example

```4d

    // User_Localise
    
    C_TEXT($0)  // TARGET STRING = LOCALISED OR THE ORIGINAL SOURCE WITH % PREFIX FOR *ERROR HANDLING
    
    C_TEXT($1)  // SOURCE STRING
    C_TEXT($2)  // LANGUAGE CODE
    
    C_OBJECT($oDictionary)
    
    C_TEXT($txtLocalised)
    
    $oDictionary := ds.Dictionary.query("Source = :1 and Language_Code = :2";Substring($1;2);$2)
    
    If ($oDictionary # Null)
    	
    	$txtLocalised := $oDictionary[0].Target
    	
    Else 
    	  // !IMPORTANT - RETURN THE SOURCE STRING VALUE FOR *ERROR HANDLING = "%source"
    	
    	$txtLocalised := $1
    End if 
    
    $txtLocalised := Ltg_Str_Escape ($txtLocalised)
    
    $0 := $txtLocalised
```