//%attributes = {"shared":true}
C_OBJECT:C1216($oCompany)  // COMPANY RECORD

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oCompany:=ds:C1482.Company.get(oConnection.data.Company.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oCompany=Null:C1517)
	
	$oCompany:=ds:C1482.Company.new()
	
End if 

$oCompany.companyName:=oConnection.data.Company.companyName
$oCompany.address:=oConnection.data.Company.address
$oCompany.city:=oConnection.data.Company.city
$oCompany.state:=oConnection.data.Company.state
$oCompany.postalCode:=oConnection.data.Company.postalCode
$oCompany.phone1:=oConnection.data.Company.phone1
$oCompany.phone2:=oConnection.data.Company.phone2
$oCompany.fax:=oConnection.data.Company.fax
$oCompany.email:=oConnection.data.Company.email
$oCompany.website:=oConnection.data.Company.website
$oCompany.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="company")
		
		oConnection.form:="bbcompany-list.html"
		oConnection.action:="index"
		
		
	: (oConnection.referer="person")
		oConnection.data.Person.company:=String:C10($oCompany.companyID)
		oConnection.data.Person.companyID:=$oCompany.companyID
		Ltg_JS_Send("ltgSelectAddOption('Person.company','"+String:C10($oCompany.companyID)+"','"+$oCompany.companyName+"')")
		Ltg_JS_Send("ltgSelectSetValue('Person.company','"+String:C10($oCompany.companyID)+"')")
		
		oConnection.form:="person-detail.html"
		oConnection.action:="index"
		
		oConnection.responseType:="javascript"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
