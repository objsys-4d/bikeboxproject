 <!--
    Ltg_URL_GetParam ( name [text] ) -> value [text]
        
    Get the value of a URL parameter.
 -->
 
# Ltg_URL_GetParam

*Ltg_URL_GetParam* ( _name_ [text] ) -> _value_ [text]

## Description

Get the value of a URL parameter.


## Parameters

 Parameter    | Description                        | Type
------------  |-------------                       |-------------
*name*        | URL parameter name                 | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*value*        | URL parameter value               | [text]

## Example

### URL

```4d
    http://localhost:8080/companies?company=EA6569481A464EC797871FE04015C686
```

### 4D

```4d
    // COMPANY_ID PASSED AS URL PARAMETER?
		
	$txtCompany_ID :=Ltg_URL_GetParam ("company")
		
	If ($txtCompany_ID#"")
			
        // LOAD THE COMPANY

		$oCompany:=ds.Companies.get($txtCompany_ID)
	End if 
```