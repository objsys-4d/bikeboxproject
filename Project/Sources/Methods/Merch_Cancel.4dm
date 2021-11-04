//%attributes = {"shared":true}
// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="merch?@")  // VIA URL
		
		oConnection.form:="merchlist.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="merch")
		
		// RETURN TO THE merch LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.merchList.pageNumber:=Abs:C99(Int:C8(-(oUser.merchDetail.pageNumber/(oUser.merchList.pageSize))))
		
		oConnection.form:="merchlist.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
