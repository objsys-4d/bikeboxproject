//%attributes = {"shared":true}
C_OBJECT:C1216($oCompany)  // COMPANY RECORD

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oCompany:=ds:C1482.Companies.get(oConnection.data.Company.Company_ID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oCompany=Null:C1517)
	
	$oCompany:=ds:C1482.Companies.new()
	
End if 

$oCompany.Company_Name:=oConnection.data.Company.Company_Name
$oCompany.Address:=oConnection.data.Company.Address
$oCompany.City:=oConnection.data.Company.City
$oCompany.County:=oConnection.data.Company.County
$oCompany.Postcode:=oConnection.data.Company.Postcode

$oCompany.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="companies")
		
		oConnection.form:="companies-list.html"
		oConnection.action:="index"
		
	: (oConnection.referer="contacts")
		
		oConnection.form:="contacts-list.html"
		oConnection.action:="index"
		
	: (oConnection.referer="orders")
		
		oConnection.form:="orders-list.html"
		oConnection.action:="index"
End case 
