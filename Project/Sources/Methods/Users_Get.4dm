//%attributes = {}
C_TEXT:C284($0)

C_TEXT:C284($txtUsers)

$oPreferences:=ds:C1482.Preferences.all().first()

If ($oPreferences#Null:C1517)
	
	$txtUsers:=$oPreferences.Users
	
Else 
	
	$txtUsers:=""
End if 

$0:=$txtUsers
