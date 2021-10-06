//%attributes = {"shared":true}
Case of 
		
	: (oConnection.referer="companies")
		
		  // UPDATE CONNECTION...
		
		oConnection.form:="companies-detail.html"
		oConnection.action:="edit"
		
		oConnection.responseType:="javascript"
		
	: (oConnection.referer="contacts")
		
		  // PUBLISH FORM
		
		oConnection.form:="contacts-list.html"
		
End case 

