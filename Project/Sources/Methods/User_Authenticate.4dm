//%attributes = {}
C_BOOLEAN:C305($0)  // <- AUTHENTICATED LOGIN

C_BOOLEAN:C305($flAuthenticated)

C_TEXT:C284($txtUser_Name)  // login.html
C_TEXT:C284($txtUser_Language)  // login.html
C_TEXT:C284($txtUser_Password)  // login.html
C_TEXT:C284($txtUser_Redirect)  //login.html

// INITIALISE RETURN FLAG

$flAuthenticated:=False:C215

// INITIALISE ERROR MESSAGE?

If (OB Get type:C1230(oConnection.data; "userError")=Is undefined:K8:13)
	
	oConnection.data.userError:=""
End if 

// INITIALISE INFORMATION MESSAGE?

If (OB Get type:C1230(oConnection.data; "userInfo")=Is undefined:K8:13)
	
	oConnection.data.userInfo:=""
End if 

// INITIALISE URL REDIRECT?

If (OB Get type:C1230(oConnection.data; "userRedirect")=Is undefined:K8:13)
	
	oConnection.data.userRedirect:=""
End if 

// GET CONNECTION DATA (login.html)

$txtUser_Name:=oConnection.data.userName
$txtUser_Password:=oConnection.data.userPassword
$txtUser_Language:=oConnection.data.userLanguage
$txtUser_Redirect:=oConnection.data.userRedirect

// EMPTY USERNAME/PASSSWORD? COULD THIS BE A REDIRECT?

If (($txtUser_Name="") & ($txtUser_Password=""))
	
	// CACHE QUALIFIED NON-EMPTY URL FOR REDIRECTION AFTER LOGIN?
	
	If ((oConnection.url#"/LTGAJAX") & (oConnection.url#"/") & (oConnection.url#"/login") & (oConnection.url#"/logout"))
		
		// USER INFORMATION MESSAGE
		
		oConnection.data.userInfo:="Please login and you will be directed to the relevant page."
		
		// SET THE REDIRECT (CURRENT URL VALUE)
		
		oConnection.data.userRedirect:=oConnection.url
	End if 
	
Else 
	
	// THERE IS A USER NAME AND/OR PASSWORD ENTERED...
	
	READ ONLY:C145([Users:1])
	
	QUERY:C277([Users:1]; [Users:1]User_Name:1=$txtUser_Name)
	
	$flAuthenticated:=(Records in selection:C76([Users:1])=1)
	
	// VALID USER NAME?
	
	If ($flAuthenticated)
		
		// ACCOUNT ACTIVATED?
		
		$flAuthenticated:=([Users:1]Activated:8)
		
		If ($flAuthenticated)
			
			// VALIDATE PASSWORD
			
			$flAuthenticated:=($txtUser_Password=[Users:1]Password:5)
			
			// VALID PASSWORD?
			
			If ($flAuthenticated)
				
				// GOOD TO GO!
				
				// SETUP SESSION FROM BASE CONSTRUCTOR, YOU CAN ADD CUSTOM PROPERTIES ETC...
				
				// USER NAME
				
				oConnection.session.userName:=[Users:1]User_Name:1  // !MANDATORY
				
				// USER LANGUAGE 
				
				oConnection.session.userLanguage:=$txtUser_Language  // OPTIONAL - PROPERTY WILL AUTO SET TO DEFAULT LANGUAGE
				
				// DATE FORMAT
				oConnection.session.userDateFormat:="mm/dd/yyyy"  // OPTIONAL - PROPERTY WILL AUTO SET TO SYSTEM DATE FORMAT
				
				// USER ROLE
				
				oConnection.session.userRole:=[Users:1]User_Role:6  // CUSTOM PROPERTY
				
				// USER GROUPS
				
				oConnection.session.userGroups:=[Users:1]User_Groups:7  // CUSTOM PROPERTY
				
				// CURRENCY FORMAT...
				
				Case of 
					: (oConnection.session.userLanguage="en-US")
						
						oConnection.session.userCurrency:="$###,###,##0.00"
						
					: (oConnection.session.userLanguage="en-GB")
						
						oConnection.session.userCurrency:="£###,###,##0.00"
						
					: (oConnection.session.userLanguage="fr")
						
						oConnection.session.userCurrency:="€###,###,##0.00"
				End case 
				
			Else 
				
				// ERROR MESSAGE
				
				oConnection.data.userError:="Invalid username/password combination."
			End if 
			
		Else 
			
			// ERROR MESSAGE
			
			oConnection.data.userError:="Account is not active."
		End if 
	Else 
		
		// ERROR MESSAGE
		
		oConnection.data.userError:="Account not found."
	End if 
End if 

// DISPLAY MESSAGES...

If (oConnection.data.userInfo#"")
	
	Ltg_JS_Send("ltgObj('userInfo').removeClass('d-none')")
	
End if 

If (oConnection.data.userError#"")
	
	Ltg_JS_Send("ltgObj('userError').removeClass('d-none')")
	
End if 

// !IMPORTANT: RESET USER NAME & PASSWORD

oConnection.data.userName:=""
oConnection.data.userPassword:=""

$0:=$flAuthenticated