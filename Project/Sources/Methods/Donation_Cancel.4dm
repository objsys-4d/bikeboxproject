//%attributes = {"shared":true}
// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="donation?@")  // VIA URL
		
		oConnection.form:="donations-list.html"
		oConnection.action:="tab"
		
	: (oConnection.referer="donation")
		
		// RETURN TO THE DONATION LIST FORM (AT THE CORRECT PAGE SHOULD THE PAGINATION HAVE CHANGED IN THE DETAIL FORM)
		
		oUser.donationList.pageNumber:=Abs:C99(Int:C8(-(oUser.donationDetail.pageNumber/(oUser.donationList.pageSize))))
		
		oConnection.form:="donations-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
