//%attributes = {"shared":true}
// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="order?@")  // VIA URL
		
		oConnection.form:="bborder-list.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="order")
		
		// RETURN TO THE order LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.orderList.pageNumber:=Abs:C99(Int:C8(-(oUser.orderDetail.pageNumber/(oUser.orderList.pageSize))))
		
		oConnection.form:="order-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
