//%attributes = {"shared":true}
// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="company?@")  // VIA URL
		
		oConnection.form:="bbcompany-list.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="company")
		
		// RETURN TO THE COMPANY LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.companyList.pageNumber:=Abs:C99(Int:C8(-(oUser.companyDetail.pageNumber/(oUser.companyList.pageSize))))
		
		oConnection.form:="bbcompany-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
