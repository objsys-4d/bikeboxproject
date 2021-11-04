//%attributes = {"shared":true}
C_OBJECT:C1216(oConnection)  // CONNECTION OBJECT (PROCESS VARIABLE)

C_OBJECT:C1216(oUser)  // CURRENT USER OBJECT (PROCESS VARIABLE)

// GET THE CONNECTION OBJECT

oConnection:=Ltg_Conn_Get

// LOGOUT OR SESSION EXPIRED?

If ((oConnection.url="/logout") | ((oConnection.session.expired=True:C214) & (oConnection.session.LTGSID#"")))
	
	// CLOSE THE SESSION
	
	User_Logout
End if 

// AUTHENTICATE LOGIN? (VIA LOGIN URL OR INACTIVE SESSION)

If ((oConnection.url="/login") | (oConnection.session.LTGSID=""))
	
	// AUTHENTICATE
	
	If (User_Authenticate)
		
		// CREATE SESSION
		
		User_Login
		
	Else 
		
		// PUBLISH THE LOGIN FORM
		
		oConnection.url:="/login"
	End if 
End if 

// GET THE CURRENT USER OBJECT

oUser:=Ltg_User_Get(oConnection.session.userName)

// IF THERE IS NOT A CURRENT FORM NAME? (E.G. URL BASED CONNECTION)

If ((oConnection.url#"/login") & (oConnection.form=""))
	
	// PUBLISH INDEX.HTML AS THE FORM CONTAINER
	
	oConnection.formContainer:="index.html"
End if 

// RESET NAVBAR

Navbar_SetActive("")

// PROCESS INCOMING ROUTES...

// !IMPORTANT: LIGHTNING AJAX REQUEST URL = /LTGAJAX

Case of 
		// *** AUTHENTICATE...
		
	: (oConnection.url="/login")
		
		oConnection.form:="login.html"
		
		// *** DASHBOARD...
		
	: ((oConnection.url="/") | (oConnection.form="dashboard.html"))
		
		oConnection.form:="dashboard.html"
		
		If (oConnection.action="")
			
			oConnection.action:="tab"
			
		End if 
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-dashboard")
		
		// *** COMPANIES...
		
	: ((oConnection.url="/companies") | (oConnection.form="companies-list.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="companies-list.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/companies"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-companies")
		
	: (oConnection.url="/companies?@")  // DETAIL
		
		oConnection.form:="companies-detail.html"
		oConnection.action:="edit"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-companies")
		
		// *** CONTACTS...
		
	: ((oConnection.url="/contacts") | (oConnection.form="contacts-list.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="contacts-list.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/contacts"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-contacts")
		
		// *** PRODUCTS...
		
	: ((oConnection.url="/products") | (oConnection.form="products-list.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="products-list.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/products"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-products")
		
		// *** ORDERS...
		
	: ((oConnection.url="/orders") | (oConnection.form="orders-list.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="orders-list.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/orders"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-orders")
		
		// PERSON
		
		Navbar_SetActive("nav-person")
		
	: ((oConnection.url="/person") | (oConnection.form="personlist.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="personlist.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/person"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-person")
		
	: (oConnection.url="/person?@")  // DETAIL
		
		oConnection.form:="persondetail.html"
		oConnection.action:="edit"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-person")
		
	: ((oConnection.url="/company") | (oConnection.form="companylist.html"))  // LIST
		
		If (oConnection.form="")
			
			oConnection.form:="companylist.html"
			oConnection.action:="tab"
		End if 
		oConnection.url:="/company"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-company")
		
	: (oConnection.url="/company?@")  // DETAIL
		
		oConnection.form:="companydetail.html"
		oConnection.action:="edit"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-company")
		
	: ((oConnection.url="/donation") | (oConnection.form="donationlist.html"))  // DETAIL
		
		If (oConnection.form="")
			oConnection.form:="donationlist.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/donation"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-donation")
		
	: ((oConnection.url="/event") | (oConnection.form="eventlist.html"))  // DETAIL
		
		If (oConnection.form="")
			oConnection.form:="eventlist.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/event"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-event")
		
	: ((oConnection.url="/merch") | (oConnection.form="merchlist.html"))  // DETAIL
		
		If (oConnection.form="")
			oConnection.form:="merchlist.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/merch"
		
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-merch")
		
		
	: ((oConnection.url="/order") | (oConnection.form="order-list.html"))  // DETAIL
		
		If (oConnection.form="")
			oConnection.form:="order-list.html"
			oConnection.action:="tab"
		End if 
		
		oConnection.url:="/order"
		// SET ACTIVE NAVBAR ITEM
		Navbar_SetActive("nav-order")
		
		
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
		
		Navbar_SetActive("nav-demos")
		
	: (oConnection.url="/demos-uppy")  // UPPY PLUGIN
		
		// SET THE METHOD TO UPLOAD THE FILE(S)...
		
		oConnection.action:="file"
		oConnection.method:="Demos_File_Upload"
		
		// BLANK PAGE...
		
	: ((oConnection.url="/blank") | (oConnection.form="blank.html"))
		
		If (oConnection.form="")
			
			oConnection.form:="blank.html"
			oConnection.action:="blank"
		End if 
		
		oConnection.url:="/blank"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-demos")
		
		// *** AJAX REQUEST
		
	: (oConnection.url="/LTGAJAX")
		
		// THE BELOW STATEMENT WILL MAP A "SEARCH" ACTION TO A LIST FORM...
		
		If (oConnection.action="search")
			
			Case of 
				: (oConnection.referer="company")
					
					oConnection.form:="bbcompanies-list.html"
					
				: (oConnection.referer="person")
					
					oConnection.form:="personlist.html"
					
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
		oConnection.action:="404"
		
		// SET ACTIVE NAVBAR ITEM
		
		Navbar_SetActive("nav-demos")
End case 

// NOT A JSON RESPONSE?

If (oConnection.responseType#"json")
	
	// NOT A /LTGAJAX REQUEST?
	
	If (oConnection.url#"/LTGAJAX")
		
		// UPDATE THE BROWSER HISTORY WITH THE ROUTED URL
		
		Ltg_JS_Send("history.pushState(null, null, '"+oConnection.url+"')")
	End if 
End if 

// PUBLISH THE REQUEST

Web_Publish
