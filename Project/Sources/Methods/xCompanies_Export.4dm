//%attributes = {"shared":true}
C_BLOB:C604($bloData)  // DOCUMENT CONTENT

C_OBJECT:C1216($oCompany)  // CURRENT COMPANY
C_OBJECT:C1216($oCompanies)  // CURRENT SELECTION OF COMPANIES

C_TEXT:C284($txtData)  // DOCUMENT CONTENT

// GET THE CURRENT SELECTION

$oCompanies:=xCompanies_List

If ($oCompanies.length>0)
	
	// CREATE DOCUMENT DATA...
	
	// HEADER...
	
	$txtData:=Ltg_Str_Localise("%company_name")+Char:C90(Tab:K15:37)
	$txtData:=$txtData+Ltg_Str_Localise("%address")+Char:C90(Tab:K15:37)
	$txtData:=$txtData+Ltg_Str_Localise("%city")+Char:C90(Tab:K15:37)
	$txtData:=$txtData+Ltg_Str_Localise("%county")+Char:C90(Tab:K15:37)
	$txtData:=$txtData+Ltg_Str_Localise("%postcode")+Char:C90(Tab:K15:37)
	
	$txtData:=$txtData+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	
	// ROWS...
	
	For each ($oCompany; $oCompanies)
		
		$txtData:=$txtData+$oCompany.Company_Name+Char:C90(Tab:K15:37)
		$txtData:=$txtData+Replace string:C233($oCompany.Address; Char:C90(Carriage return:K15:38); ",")+Char:C90(Tab:K15:37)
		$txtData:=$txtData+$oCompany.City+Char:C90(Tab:K15:37)
		$txtData:=$txtData+$oCompany.County+Char:C90(Tab:K15:37)
		$txtData:=$txtData+$oCompany.Postcode+Char:C90(Tab:K15:37)
		
		$txtData:=$txtData+Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
		
	End for each 
	
	TEXT TO BLOB:C554($txtData; $bloData; UTF8 text without length:K22:17)
	
	// DOWNLOAD TO CLIENT
	
	Ltg_File_Download("companies.txt"; False:C215; $bloData)
	
End if 
