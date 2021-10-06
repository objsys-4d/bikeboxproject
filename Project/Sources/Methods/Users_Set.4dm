//%attributes = {}
C_OBJECT:C1216($oPreferences)

  // SAVE THE USERS COLLECTION SO THAT IT CAN BE PERSISTED ON THE NEXT STARTUP AS USER PREFERENCES (REFER TO "Web_Startup")

$oPreferences:=ds:C1482.Preferences.all().first()

If ($oPreferences=Null:C1517)
	
	$oPreferences:=ds:C1482.Preferences.new()
End if 

$oPreferences.Users:=JSON Stringify:C1217(Ltg_Users_Get )

$oPreferences.save()
