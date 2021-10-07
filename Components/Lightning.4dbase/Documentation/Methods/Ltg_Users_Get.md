 <!--
    Ltg_Users_Get -> users [collection]
        
    Gets the users collection.
 -->
 
# Ltg_Users_Get

*Ltg_Users_Get* -> _users_ [collection]

## Description

Get the users collection.

## Result

 Result       | Description            | Type
------------  |-------------           |-------------
*users*       | Users collection       | [collection]

```4d

    // Users_Set
    
    C_OBJECT($oPreferences)

    // SAVE THE USERS COLLECTION SO THAT IT CAN BE PERSISTED ON THE NEXT STARTUP AS SAVED PREFERENCES

    $oPreferences :=ds.Preferences.all().first()

    If ($oPreferences=Null)
	
	   $oPreferences :=ds.Preferences.new()
    End if 

    $oPreferences.Users :=JSON Stringify(Ltg_Users_Get )

    $oPreferences.save()
```

## See also

**Ltg_User_Get**

**Ltg_Shutdown**