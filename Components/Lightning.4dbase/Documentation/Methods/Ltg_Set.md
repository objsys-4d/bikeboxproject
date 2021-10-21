 <!--
    Ltg_Set ( category [text] ; setting [value] ; value [text] ) -> error [longint]
        
    Set the value of a Lightning category setting.
 -->
 
# Ltg_Set

*Ltg_Set* ( _category_ [text] ; _setting_ [text] ; _value_ [text] ) -> error [longint]

## Description

Set the value of a Lightning category setting.

## Parameters

 Parameter    | Type
------------  |-------------
*category*    | [text]
*setting*     | [text]
*value*       | [text]

## Result

 Result         | Description                       | Type
------------    |-------------                      |-------------
*error*         | Error code                        | [longint]

## Settings

 Category       | Setting            | Description                                       | Type
------------    |-------------       |-------------                                      |-------------
*language*      | default            | Default language                                  | [text]
*log*           | level              | Log level                                         | [text]
*method*        | localise           | Callback method for "%" directives                | [text]
*method*        | ntk                | Callback method for NTK Web Connections           | [text]
*method*        | router             | Callback method for Connection Router             | [text]
*users*         | preferences        | Saved user Session preferences                    | [text]
*web*           | folder             | Web Folder location                               | [text]
*web*           | http               | HTTP Port number                                  | [text]
*web*           | https              | HTTPS Port number                                 | [text]
*web*           | maxrequestsize     | Maximum size (in bytes) of incoming HTTP requests | [text]
*web*           | parseheadertimeout | Parse header timeout (milliseconds), NTK only     | [text]
*web*           | parsebodytimeout   | Parse body timeout (milliseconds), NTK only       | [text]
*web*           | threadpoolcount    | Worker threadpool count, NTK only                 | [text]

## Example

```4d	

    // Web_Startup
    
	// SET ANALYTICS LEVEL (0 = OFF, 1 = ON) THIS IS FOR MATOMO SUPPORT

    Ltg_Set ("analytics";"level";"0")
    
      // SET DEFAULT LANGUAGE FOR LOCALISATION
    
    Ltg_Set ("language";"default";"en-GB")  // REFER TO [DICTIONARY]
    
      // SET LOG LEVEL...
    
      // 0 = OFF (FASTEST)
    
      // 1 = ON - PERFORMANCE AND ERROR MESSAGES (FAST)
    
      // 2 = ON - PERFORMANCE, INFORMATION MESSAGES AND ERROR MESSAGES (MEDIUM)
    
      // 3 = ON - PERFORMANCE, INFORMATION MESSAGES, ERROR MESSAGES AND HTML TAG CHECKING (SLOW)
    
    Ltg_Set ("log";"level";"1")
    
      // SET METHODS...
    
    Ltg_Set ("method";"router";"Web_Router")  // MANDATORY
    
    Ltg_Set ("method";"localise";"User_Localise")  // OPTIONAL - REQUIRED FOR LOCALISATION
    
    Ltg_Set ("method";"ntk";"Web_NTK")  // OPTIONAL - REQUIRED FOR THE NTK PLUGIN FOR WEB SERVING
    
      // SET USERS...
    
    Ltg_Set ("users";"preferences";Users_Get )  // SET USER PREFERENCES
    
    Ltg_Set ("users";"sessiontimeout";"60")  // SET SESSION TIMEOUT TO 60 MINUTES
    
      // SET WEB...
    
    Ltg_Set ("web";"folder";Get 4D folder(Database folder)+"WebFolder")  // WEBFOLDER
    
    Ltg_Set ("web";"http";"8080")  // HTTP PORT
    
    Ltg_Set ("web";"https";"443")  // HTTPS PORT
    
    Ltg_Set ("web";"maxrequestsize";"10485760")  // SET MAXIMUM UPLOAD SIZE TO 10MB
    
    Ltg_Set ("web";"parseheadertimeout";"1000")  // NTK ONLY - 1 SECOND HEADER PARSE TIMEOUT
    
    Ltg_Set ("web";"parsebodytimeout";"10000")  // NTK ONLY - 10 SECONDS BODY PARSE TIMEOUT
    
    Ltg_Set ("web";"threadpoolcount";"10")  // NTK ONLY - 10 CONNECTION WORKER THREADS
    
      // WEB SERVER CHOICE...
    
    CONFIRM("Welcome to Lightning V5 Starter!"+(Char(Carriage return)*2)+"Which Web Server would you like to use?";"4D";"NTK")
    
    If (OK=1)
    	
    	  // 4D WEB SERVER
    	
    	$nError:=Ltg_Startup ("4D")
    Else 
    	
    	  // NTK WEB SERVER (NTK V4 IS USED IN THIS DEMO)
    	
    	$nError:=Ltg_Startup ("NTK")
    End if 
```

## See also

**Ltg_Startup**