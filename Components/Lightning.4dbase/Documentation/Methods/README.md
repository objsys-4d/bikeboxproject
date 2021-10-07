# Lightning V5 (Clean Air)

## Overview

Lightning V5 is a Web Application Framework for 4D. Included is the server 4D Component (Lightning.4dbase), and the client JavaScript library (lightning.min.js).

## System Requirements

Lightning V5 requires 4D V18R3 or greater.

## Web Server

There are two options available for the Web Server, the built-in 4D Web Server or the NTK plugin.

If you are using the 4D Web Server, incoming connection requests will be handled by the _On Web Connection_ Database Method, 
or you will need to install a custom handler method into your host database for handling the NTK Web Server requests, refer to the _Web_NTK_ method, in the demonstration, which mimics the 4D On Web Connection method.

[NTK Plugin](https://www.pluggers.nl/product/ntk-plugin/)

## Lightning V5 Starter
Please review the Lightning V5 Starter demonstration database that is provided.

1. Open Lightning Starter with 4D
2. You will be asked to choose either 4D or NTK as the Web Server and your browser will display the Login form
3. Login as one of the following users;

 User name     | Password       
:------------   |:-------------
designer    | Ltg
administrator    | LetAdminIn
mhammond    | CSS

## Theme

The theme used for Lightning V5 Starter is the June 2020 release of SB Admin 2, a free Bootstrap 4 admin theme which uses a number of third-party JavaScript plugins to support the demonstration.

[SB Admin 2](https://startbootstrap.com/themes/sb-admin-2/)

## Startup

```4d

    // Web_Startup
    
    C_LONGINT($nError)
    C_LONGINT($lPort)
    
    CONFIRM("Welcome to Lightning V5 Starter"+(Char(Carriage return)*2)+"Which Web Server would you like to use?";"4D";"NTK")
    
    If (OK=1)
    	
    	  // 4D WEB SERVER - SET MAXIMUM UPLOAD SIZE TO 10MB
    	
    	$nError:=Ltg_Startup ("4D";10485760)
    Else 
    	
    	  // NTK WEB SERVER (V3 / V4 SUPPORTED) - SET MAXIMUM UPLOAD SIZE TO 10MB, PARSE HEADER TO 1 SECOND MAX, PARSE BODY TO 10 SECONDS MAX, 12 WORKER THREADS
    	
    	$nError:=Ltg_Startup ("NTK";10485760;1000;10000;12)
    End if 
    
    If ($nError=0)
    	
    	  // *** PRODUCT REGISTRATION - UNCOMMENT AND ADD YOUR LICENCE DETAILS
    	
    	  //$nError:=Ltg_Register ("<name>";"<number>")
    	
    	  // SET DEFAULT LANGUAGE FOR LOCALISATION
    	
    	Ltg_Set ("language";"default";"en-GB")  // REFER TO [DICTIONARY]
    	
    	  // SET LOG LEVEL...
    	
    	  // 0 = OFF (FASTEST)
    	
    	  // 1 = ON - PERFORMANCE AND ERROR MESSAGES (FAST)
    	
    	  // 2 = ON - PERFORMANCE, INFORMATION MESSAGES AND ERROR MESSAGES (MEDIUM)
    	
    	  // 3 = ON - PERFORMANCE, INFORMATION MESSAGES, ERROR MESSAGES AND HTML TAG CHECKING (SLOW)
    	
    	Ltg_Set ("log";"level";"1")
    	
    	  // SET CALLBACK METHODS...
    	
    	Ltg_Set ("method";"router";"Web_Router")  // MANDATORY
    	
    	Ltg_Set ("method";"localise";"User_Localise")  // OPTIONAL (REQUIRED FOR LOCALISTATION)
    	
    	Ltg_Set ("method";"ntk";"Web_NTK")  // OPTIONAL (REQUIRED FOR NTK PLUGIN)
    	    	
    	  // SET USERS...
    	
    	Ltg_Set ("users";"preferences";Users_Get )  // SET USER PREFERENCES
    	
    	Ltg_Set ("users";"sessiontimeout";"60")  // SET SESSION TIMEOUT TO 60 MINUTES
    	
    	WEB GET OPTION(Web Port ID;$lPort)
    	
    	OPEN URL("localhost:"+String($lPort)+"/")
    End if 
```


## Login

### login.html

```4d
<form action="/login" autocomplete="off" id="lightning" name="lightning" method="post">
    
    <!--FORM METHOD--> 
    {{Login_Form}} 
    <!--/FORM METHOD-->
    
    <!--REDIRECT-->
    <input type="hidden" id=".userRedirect" name=".userRedirect" value="{{.userRedirect}}"/>
    <!--/REDIRECT-->
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4" id="welcome"></h1>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" id=".userName" class="form-control" name=".userName"
                                            placeholder="" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="password" id=".userPassword" class="form-control" name=".userPassword"
                                            placeholder="" required>
                                    </div>
                                    <div class="form-group">
                                        <select class="custom-select" id=".userLanguage"
                                            name=".userLanguage" onchange="ltgExecuteMethod('Login_Language/'+this.value);">
                                            <option selected value="en-GB">English</option>
                                            <option value="fr">Français</option>
                                        </select>
                                    </div> 
                                    
                                    <div class="alert alert-info d-none" id="userInfo" role="alert">
                                        {{.userInfo}} 
                                    </div> 
                                    
                                    <div class="alert alert-danger d-none" id="userError" role="alert"> 
                                        {{.userError}} 
                                    </div> 
                                    
                                    <button
                                        class="btn btn-lg btn-primary btn-user btn-block"
                                        onclick="document.lightning.submit();" id="login"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>		
```

### 4D Form Load Method

```4d
    // Login_Form
    
    // INITIALISE USER NAME AND USER PASSWORD
    
    oConnection.data.userName:=""
    oConnection.data.userPassword:=""
    
    // SET THE PLACEHOLDER VALUES FOR THE DEFAULT LANGUAGE (en-GB)
    
    Login_Language ("en-GB")
```

### 4D Form Submit Method

```4d
 
    // User_Authenticate
    
    C_BOOLEAN($0)  // <- AUTHENTICATED LOGIN
    
    C_BOOLEAN($flAuthenticated)
    
    C_TEXT($txtUser_Name)  // login.html
    C_TEXT($txtUser_Language)  // login.html
    C_TEXT($txtUser_Password)  // login.html
    C_TEXT($txtUser_Redirect)  //login.html
    
      // INITIALISE RETURN FLAG
    
    $flAuthenticated:=False
    
      // INITIALISE ERROR MESSAGE?
    
    If (OB Get type(oConnection.data;"userError")=Is undefined)
    	
    	oConnection.data.userError:=""
    End if 
    
      // INITIALISE INFORMATION MESSAGE?
    
    If (OB Get type(oConnection.data;"userInfo")=Is undefined)
    	
    	oConnection.data.userInfo:=""
    End if 
    
      // INITIALISE URL REDIRECT?
    
    If (OB Get type(oConnection.data;"userRedirect")=Is undefined)
    	
    	oConnection.data.userRedirect:=""
    End if 
    
      // GET CONNECTION DATA (login.html)
    
    $txtUser_Name:=oConnection.data.userName
    $txtUser_Password:=oConnection.data.userPassword
    $txtUser_Language:=oConnection.data.userLanguage
    $txtUser_Redirect:=oConnection.data.userRedirect
    
      // EMPTY USERNAME/PASSSWORD? COULD THIS BE A RIDIRECT?
    
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
    	
    	READ ONLY([Users])
    	
    	QUERY([Users];[Users]User_Name=$txtUser_Name)
    	
    	$flAuthenticated:=(Records in selection([Users])=1)
    	
    	  // VALID USER NAME?
    	
    	If ($flAuthenticated)
    		
    		  // ACCOUNT ACTIVATED?
    		
    		$flAuthenticated:=([Users]Activated)
    		
    		If ($flAuthenticated)
    			
    			  // VALIDATE PASSWORD
    			
    			$flAuthenticated:=($txtUser_Password=[Users]Password)
    			
    			  // VALID PASSWORD?
    			
    			If ($flAuthenticated)
    				
    				  // GOOD TO GO!
    				
    				  // SETUP SESSION FROM BASE CONSTRUCTOR, YOU CAN ADD CUSTOM PROPERTIES ETC...
    				
    				  // USER NAME
    				
    				oConnection.session.userName:=[Users]User_Name  // !MANDATORY
    				
    				  // USER LANGUAGE 
    				
    				oConnection.session.userLanguage:=$txtUser_Language  // OPTIONAL - PROPERTY WILL AUTO SET TO DEFAULT LANGUAGE
    				
    				  // DATE FORMAT
    				oConnection.session.userDateFormat:="dd/mm/yyyy"  // OPTIONAL - PROPERTY WILL AUTO SET TO SYSTEM DATE FORMAT
    				
    				  // USER ROLE
    				
    				oConnection.session.userRole:=[Users]User_Role  // CUSTOM PROPERTY
    				
    				  // USER GROUPS
    				
    				oConnection.session.userGroups:=[Users]User_Groups  // CUSTOM PROPERTY
    				
    				  // CURRENCY FORMAT...
    				
    				Case of 
    						
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
    	
    	Ltg_JS_Send ("ltgObj('userInfo').removeClass('d-none')")
    	
    End if 
    
    If (oConnection.data.userError#"")
    	
    	Ltg_JS_Send ("ltgObj('userError').removeClass('d-none')")
    	
    End if 
    
      // !IMPORTANT: RESET USER NAME & PASSWORD
    
    oConnection.data.userName:=""
    oConnection.data.userPassword:=""
    
    $0:=$flAuthenticated

```

## Session

Creates a new session and tests for either redirect or default form. The url is changed accordingly and routed via the method _Web_Router_.

```4d
  // CREATE A NEW SESSION

Ltg_Session_New 

  // REFER TO THE METHOD "WEB_ROUTER" TO SEE HOW THIS WORKS WITH THE URL

  // REDIRECT?

If (oConnection.data.userRedirect#"")
	
	oConnection.url:=oConnection.data.userRedirect
	
Else 
	  // DEFAULT TO THE DASHBOARD
	
	oConnection.url:="/"
End if 
```

## Routing

```4d
    http://localhost:8080/companies?company=EA6569481A464EC797871FE04015C686
```

```4d

    // Web_Router
    
    C_OBJECT(oConnection)  // CONNECTION OBJECT (PROCESS VARIABLE)
    
    C_OBJECT(oUser)  // CURRENT USER OBJECT (PROCESS VARIABLE)
    
      // !IMPORTANT: AJAX REQUEST URL = /LTGAJAX
    
      // GET THE CONNECTION OBJECT
    
    oConnection:=Ltg_Conn_Get 
    
      // LOGOUT OR SESSION EXPIRED?
    
    If ((oConnection.url="/logout") | (oConnection.session.expired=True))
    	
    	  // CLOSE THE SESSION
    	
    	User_Logout 
    End if 
    
      // AUTHENTICATE LOGIN? (VIA LOGIN URL OR INACTIVE SESSION)
    
    If ((oConnection.url="/login") | (oConnection.session.LTGSID=""))
    	
    	  // AUTHENTICATE
    	
    	If (User_Authenticate )
    		
    		  // CREATE SESSION
    		
    		User_Login 
    		
    	Else 
    		
    		  // RETURN USER TO THE LOGIN FORM
    		
    		oConnection.url:="/login"
    	End if 
    End if 
    
      // GET THE CURRENT USER OBJECT
    
    oUser:=Ltg_User_Get (oConnection.session.userName)
    
      // IF THERE IS NOT A CURRENT FORM NAME? (E.G. URL BASED CONNECTION)
    
    If ((oConnection.url#"/login") & (oConnection.form=""))
    	
    	  // PUBLISH INDEX.HTML AS THE FORM CONTAINER
    	
    	oConnection.formContainer:="index.html"
    End if 
    
      // RESET NAVBAR
    
    Navbar_SetActive ("")
    
      // PROCESS INCOMING ROUTES...
    
    Case of 
    		
    		  // *** AUTHENTICATE...
    		
    	: (oConnection.url="/login")
    		
    		oConnection.form:="login.html"
    		
    		  // *** DASHBOARD...
    		
    	: ((oConnection.url="/") | (oConnection.form="dashboard.html"))
    		
    		oConnection.form:="dashboard.html"
    		oConnection.action:="tab"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-dashboard")
    		
    		  // *** COMPANIES...
    		
    	: ((oConnection.url="/companies") | (oConnection.form="companies-list.html"))  // LIST
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="companies-list.html"
    			oConnection.action:="tab"
    		End if 
    		
    		oConnection.url:="/companies"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-companies")
    		
    	: (oConnection.url="/companies?@")  // DETAIL
    		
    		oConnection.form:="companies-detail.html"
    		oConnection.action:="edit"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-companies")
    		
    		  // *** CONTACTS...
    		
    	: ((oConnection.url="/contacts") | (oConnection.form="contacts-list.html"))  // LIST
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="contacts-list.html"
    			oConnection.action:="tab"
    		End if 
    		
    		oConnection.url:="/contacts"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-contacts")
    		
    		  // *** PRODUCTS...
    		
    	: ((oConnection.url="/products") | (oConnection.form="products-list.html"))  // LIST
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="products-list.html"
    			oConnection.action:="tab"
    		End if 
    		
    		oConnection.url:="/orders"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-products")
    		
    		
    		  // *** ORDERS...
    		
    	: ((oConnection.url="/orders") | (oConnection.form="orders-list.html"))  // LIST
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="orders-list.html"
    			oConnection.action:="tab"
    		End if 
    		
    		oConnection.url:="/orders"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-orders")
    		
    	: (oConnection.url="/orders-datatable?@")  // ORDERS DATATABLE (SERVER SIDE JSON)
    		
    		  // SET THE METHOD TO CREATE THE DATATABLE...
    		
    		oConnection.action:="method"
    		oConnection.method:="Orders_DataTable"
    		
    		  // !IMPORTANT: SET RESPONSE CONTENT TYPE TO "JSON"
    		
    		oConnection.responseType:="json"
    		
    		  // *** DEMOS...
    		
    	: ((oConnection.url="/demos") | (oConnection.form="demos.html"))
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="demos.html"
    			oConnection.action:="edit"
    		End if 
    		
    		oConnection.url:="/demos"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-demos")
    		
    	: (oConnection.url="/demos-uppy")  // UPPY PLUGIN
    		
    		  // SET THE METHOD TO UPLOAD THE FILE(S)...
    		
    		oConnection.action:="file"
    		oConnection.method:="Demos_File_Upload"
    		
    		  // BLANK PAGE...
    		
    	: ((oConnection.url="/blank") | (oConnection.form="blank.html"))
    		
    		If (oConnection.form="")
    			
    			oConnection.form:="blank.html"
    			oConnection.action:=""
    		End if 
    		
    		oConnection.url:="/blank"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-demos")
    		
    		  // *** AJAX REQUEST
    		
    	: (oConnection.url="/LTGAJAX")
    		
    		  // THE BELOW WILL MAP A "SEARCH" ACTION TO A LIST FORM...
    		
    		If (oConnection.action="search")
    			
    			Case of 
    				: (oConnection.referer="companies")
    					
    					oConnection.form:="companies-list.html"
    					
    				: (oConnection.referer="contacts")
    					
    					oConnection.form:="contacts-list.html"
    					
    				: (oConnection.referer="orders")
    					
    					oConnection.form:="orders-list.html"
    			End case 
    		End if 
    	Else 
    		
    		  // UNKNOWN - PUBLISH 404
    		
    		oConnection.form:="404.html"
    		
    		  // SET ACTIVE NAVBAR ITEM
    		
    		Navbar_SetActive ("nav-demos")
    End case 
    
      // NOT A JSON RESPONSE?
    
    If (oConnection.responseType#"json")
    	
    	  // NOT A /LTGAJAX REQUEST?
    	
    	If (oConnection.url#"/LTGAJAX")
    		
    		  // UPDATE THE BROWSER HISTORY WITH THE ROUTED URL
    		
    		Ltg_JS_Send ("history.pushState(null, null, '"+oConnection.url+"')")
    	End if 
    End if 
    
      // PUBLISH THE REQUEST
    
    Web_Publish 
```

## Publish

```4d

    // Web_Publish
    
    Case of 
    		
    	: (oConnection.responseType="json")
    		
    		If (oConnection.action="method")
    			
    			  // UPDATE CLIENT JSON
    			
    			Ltg_Method_Execute (oConnection.method)
    		End if 
    		
    	: (oConnection.responseType="html")
    		
    		Case of 
    				
    			: (oConnection.action="file")
    				
    				Ltg_Method_Execute (oConnection.method)
    				
    			: (oConnection.action="method")
    				
    				Ltg_Method_Execute (oConnection.method)
    				
    				  // UPDATE CLIENT JS
    				
    				Ltg_Conn_Update 
    				
    				oConnection.responseType:="javascript"
    				
    			Else 
    				
    				If (oConnection.method#"")
    					
    					Ltg_Method_Execute (oConnection.method)
    					
    					  // JAVASCRIPT ONLY?
    					
    					If (oConnection.responseType="javascript")
    						
    						  // UPDATE CLIENT JS
    						
    						Ltg_Conn_Update 
    						
    					End if 
    				End if 
    				
    				  // PUBLISH FORM?
    				
    				If (oConnection.responseType="html")
    					
    					  // PUBLISH CONTENT FORM
    					
    					Ltg_Conn_PublishForm (oConnection.form)
    					
    					  // PUBLISH CONTAINER FORM (E.G. INDEX.HTML)?
    					
    					If (oConnection.formContainer#"")
    						
    						Ltg_Conn_PublishForm (oConnection.formContainer)
    					End if 
    				End if 
    				
    		End case 
    		
    		  // SET THE PAYLOAD TYPE FOR THE CLIENT
    		
    		Ltg_HTTP_SetHeader ("VND.Lightning.Payload";oConnection.responseType)
    End case 
```

## Installation

Now that you've reviewed the Lightning V5 Starter demo, you can move on to install Lightning V5 into your own project.

You do not need to alter your database structure, and Lightning will not create any external files for its own use.

The installation will contain the following items;

1. Lightning.4dbase - place this package in your _Components Folder_
2. lightning.min.js - place this script anywhere in your _HTML Root Folder_ or host externally

## Recommendations

It's highly recommended that you do not have any methods in your database with either a [_Ltg_] or [Ltg_] prefix to avoid using the same name of a method which exists in the component.


