<!--
    Ltg_Str_Localise ( source [text] ) -> target [text]

    This method is a wrapper for the method you have set for "localise" using Ltg_Set.
-->

# Ltg_Str_Localise

*Ltg_Str_Localise* ( _source_ [text] ) -> target [text]

## Description

This method is a wrapper for the method you have set for "localise" using _Ltg_Set_ and includes error handling for sources which cannot be localised.

The method will be called for localisation directives in forms and can also be used in your 4D code to provide localised text.

You can use localisation to create a multilingual application or a data dictionary feature. 

### English

![Localisation](Ltg_Str_Localise_en-GB.png "English")

### French

![Localisation](Ltg_Str_Localise_fr.png "English")

## Parameters

 Parameter      | Description                                      | Type
------------    |-------------                                     |-------------
*source*        | Source text to localise, using the "%" prefix    | [text]

## Result

 Result        | Description                                       | Type
------------   |-------------                                      |-------------
*target*       | Localised source                                  | [text]

## Example

```4d
    // Web_Startup
    
	Ltg_Set ("method";"localise";"User_Localise")
```

```4d
    // User_Localise

    C_TEXT($0)  // TARGET STRING = LOCALISED OR THE ORIGINAL SOURCE WITH % PREFIX FOR *ERROR HANDLING

    C_TEXT($1)  // SOURCE STRING
    C_TEXT($2)  // LANGUAGE CODE

    C_OBJECT($oDictionary)

    C_TEXT($txtLocalised)

    $oDictionary :=ds.Dictionary.query("Source = :1 and Language_Code = :2";Substring($1;2);$2)

    If ($oDictionary#Null)
	
	   $txtLocalised :=$oDictionary[0].Target
	
    Else 
	     // !IMPORTANT - RETURN THE SOURCE STRING VALUE FOR *ERROR HANDLING = "%source"
	
	   $txtLocalised :=$1
    End if 

    $0 :=$txtLocalised
```

## See also

**Ltg_Set**