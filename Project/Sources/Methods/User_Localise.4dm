//%attributes = {"shared":true}
C_TEXT:C284($0)  // TARGET STRING = LOCALISED OR THE ORIGINAL SOURCE WITH % PREFIX FOR *ERROR HANDLING

C_TEXT:C284($1)  // SOURCE STRING
C_TEXT:C284($2)  // LANGUAGE CODE

C_OBJECT:C1216($oDictionary)

C_TEXT:C284($txtLocalised)

$oDictionary:=ds:C1482.Dictionary.query("Source = :1 and Language_Code = :2";Substring:C12($1;2);$2).first()

If ($oDictionary#Null:C1517)
	
	$txtLocalised:=$oDictionary.Target
	
Else 
	  // !IMPORTANT - RETURN THE SOURCE STRING VALUE FOR *ERROR HANDLING = "%source"
	
	$txtLocalised:=$1
End if 

$txtLocalised:=Ltg_Str_Escape ($txtLocalised)

$0:=$txtLocalised
