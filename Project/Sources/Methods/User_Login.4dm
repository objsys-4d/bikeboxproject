//%attributes = {"shared":true}

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

  // REFER TO THE METHOD WEB_ROUTER TO SEE HOW THIS WORKS
