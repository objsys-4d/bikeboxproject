//%attributes = {"shared":true}
Case of 
		
	: (oConnection.referer="person")
		
		oUser.personList.pageNumber:=Abs:C99(Int:C8(-(oUser.personDetail.pageNumber/(oUser.personList.pageSize))))
		
		oConnection.form:="person-list.html"
		oConnection.action:="index"
		
		
		// UPDATE CONNECTION...
		
		//oConnection.form:="person-list.html"
		//oConnection.action:="tab"
		
		//oConnection.responseType:="javascript"
		
		//: (oConnection.referer="contacts")
		
		// PUBLISH FORM
		
		//oConnection.form:="contacts-list.html"
		
End case 

