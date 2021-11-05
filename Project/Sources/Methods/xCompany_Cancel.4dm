//%attributes = {"shared":true}
  // RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="companies?@")  // VIA URL
		
		oConnection.form:="companies-list.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="companies")
		
		  // RETURN TO THE COMPANIES LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.companiesList.pageNumber:=Abs:C99(Int:C8(-(oUser.companiesDetail.pageNumber/(oUser.companiesList.pageSize))))
		
		oConnection.form:="companies-list.html"
		oConnection.action:="index"
		
	: (oConnection.referer="contacts")
		
		oConnection.form:="contacts-list.html"
		oConnection.action:="index"
		
	: (oConnection.referer="orders")
		
		oConnection.form:="orders-list.html"
		oConnection.action:="index"
End case 
