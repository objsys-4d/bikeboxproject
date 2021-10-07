 <!--
    Ltg_File_Download ( name [text] ; display [boolean] ; content [blob] ) -> error [longint]
    
    Sends a file download to the client.
 -->
 
# Ltg_File_Download

*Ltg_File_Download* ( _name_ [text] ;_display_ [boolean]; _content_ [blob] ) -> _error_ [longint]

## Description

Downloads a file to the client.

## Parameters

 Parameter    | Description                                    | Type
------------  |-------------                                   |-------------
*name*        | Document name                                  | [text]
*display*     | Display in browser (if mime type is supported) | [boolean]
*content*     | Document content                               | [blob]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]

## Example

### HTML

```4d
<div class="input-group">
    <button type="button" class="btn btn-secondary"
        onclick="ltgFormAction('?action=file&method=Companies_Export');">Download</button>
</div>
```

### 4D

```4d
    // Companies_Export

    C_BLOB($bloData)  // DOCUMENT CONTENT

    C_OBJECT($oCompany)  // CURRENT COMPANY
    C_OBJECT($oCompanies)  // CURRENT SELECTION OF COMPANIES
    
    C_TEXT($txtData)  // DOCUMENT CONTENT
    
      // GET THE CURRENT SELECTION
    
    $oCompanies:=Companies_List 
    
    If ($oCompanies.length>0)
	
	  // CREATE DOCUMENT DATA...
	
	  // HEADER...
	
	$txtData:=Ltg_Str_Localise ("%company_name")+Char(Tab)
	$txtData:=$txtData+Ltg_Str_Localise ("%address")+Char(Tab)
	$txtData:=$txtData+Ltg_Str_Localise ("%city")+Char(Tab)
	$txtData:=$txtData+Ltg_Str_Localise ("%county")+Char(Tab)
	$txtData:=$txtData+Ltg_Str_Localise ("%postcode")+Char(Tab)
	
	$txtData:=$txtData+Char(Carriage return)+Char(Line feed)
	
	  // ROWS...
	
	For each ($oCompany;$oCompanies)
		
		$txtData:=$txtData+$oCompany.Company_Name+Char(Tab)
		$txtData:=$txtData+Replace string($oCompany.Address;Char(Carriage return);",")+Char(Tab)
		$txtData:=$txtData+$oCompany.City+Char(Tab)
		$txtData:=$txtData+$oCompany.County+Char(Tab)
		$txtData:=$txtData+$oCompany.Postcode+Char(Tab)
		
		$txtData:=$txtData+Char(Carriage return)+Char(Line feed)
		
	End for each 
	
	TEXT TO BLOB($txtData;$bloData;UTF8 text without length)
	
	  // DOWNLOAD TO CLIENT
	
	Ltg_File_Download ("companies.txt";False;$bloData)
	
End if 
```
