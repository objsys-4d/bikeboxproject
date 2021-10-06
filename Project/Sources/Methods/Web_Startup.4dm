//%attributes = {}
C_LONGINT:C283($nError)
C_LONGINT:C283($lPort)

// SET ANALYTICS LEVEL (0 = OFF, 1 = ON) THIS IS FOR MATOMO SUPPORT

Ltg_Set("analytics"; "level"; "0")

// SET DEFAULT LANGUAGE FOR LOCALISATION

Ltg_Set("language"; "default"; "en-US")  // REFER TO [DICTIONARY]

// SET LOG LEVEL...

// 0 = OFF (FASTEST)

// 1 = ON - PERFORMANCE AND ERROR MESSAGES (FAST)

// 2 = ON - PERFORMANCE, INFORMATION MESSAGES AND ERROR MESSAGES (MEDIUM)

// 3 = ON - PERFORMANCE, INFORMATION MESSAGES, ERROR MESSAGES AND HTML TAG CHECKING (SLOW)

Ltg_Set("log"; "level"; "2")

// SET METHODS...

Ltg_Set("method"; "router"; "Web_Router")  // MANDATORY

Ltg_Set("method"; "localise"; "User_Localise")  // OPTIONAL - REQUIRED FOR LOCALISATION

Ltg_Set("method"; "ntk"; "Web_NTK")  // OPTIONAL - REQUIRED FOR THE NTK PLUGIN FOR WEB SERVING

// SET USERS...

Ltg_Set("users"; "preferences"; Users_Get)  // SET USER PREFERENCES

Ltg_Set("users"; "sessiontimeout"; "60")  // SET SESSION TIMEOUT TO 60 MINUTES

// SET WEB...

Ltg_Set("web"; "folder"; Get 4D folder:C485(Database folder:K5:14)+"WebFolder")  // WEBFOLDER

//Ltg_Set("web";"http";"8080")  // HTTP PORT

//Ltg_Set("web";"https";"443")  // HTTPS PORT

Ltg_Set("web"; "http"; "8080")  // HTTP PORT

Ltg_Set("web"; "https"; "500")  // HTTPS PORT

Ltg_Set("web"; "maxrequestsize"; "10485760")  // SET MAXIMUM UPLOAD SIZE TO 10MB

Ltg_Set("web"; "parseheadertimeout"; "1000")  // NTK ONLY - 1 SECOND HEADER PARSE TIMEOUT

Ltg_Set("web"; "parsebodytimeout"; "10000")  // NTK ONLY - 10 SECONDS BODY PARSE TIMEOUT

Ltg_Set("web"; "threadpoolcount"; "10")  // NTK ONLY - 10 CONNECTION WORKER THREADS

// WEB SERVER CHOICE...

CONFIRM:C162("Welcome to Lightning V5 Starter!"+(Char:C90(Carriage return:K15:38)*2)+"Which Web Server would you like to use?"; "4D"; "NTK")

If (OK=1)
	
	// 4D WEB SERVER
	
	$nError:=Ltg_Startup("4D")
Else 
	
	// NTK WEB SERVER (NTK V4.x)
	
	$nError:=Ltg_Startup("NTK")
End if 

// *** PRODUCT REGISTRATION - UNCOMMENT AND ADD YOUR LICENCE DETAILS

// THE LTG_REGISTER METHOD NEEDS TO BE CALLED DIRECTLY *AFTER* LTG_STARTUP

// $nError:=Ltg_Register ("<name>";"<number>")
$nError:=Ltg_Register("Mike Beatty"; "942453-967067-873959-656045")

If ($nError=0)
	
	WEB GET OPTION:C1209(Web Port ID:K73:14; $lPort)
	
	OPEN URL:C673("localhost:"+String:C10($lPort)+"/")
Else 
	
	ALERT:C41(String:C10($nError))
End if 


