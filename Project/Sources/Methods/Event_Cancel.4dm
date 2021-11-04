//%attributes = {"shared":true}
// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="event?@")  // VIA URL
		
		oConnection.form:="eventlist.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="event")
		
		// RETURN TO THE event LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.eventList.pageNumber:=Abs:C99(Int:C8(-(oUser.eventDetail.pageNumber/(oUser.eventList.pageSize))))
		
		oConnection.form:="eventlist.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
