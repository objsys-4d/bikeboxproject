//%attributes = {"shared":true}
C_OBJECT:C1216($oPerson)  // COMPANY RECORD
C_TEXT:C284($personName)

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oPerson:=ds:C1482.Person.get(oConnection.data.Person.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oPerson=Null:C1517)
	
	$oPerson:=ds:C1482.Person.new()
	
End if 

$oPerson.lastName:=oConnection.data.Person.lastName
$oPerson.firstName:=oConnection.data.Person.firstName
$oPerson.companyID:=oConnection.data.Person.company
$oPerson.dateBirth:=Date:C102(oConnection.data.Person.dateBirth)
$oPerson.address1:=oConnection.data.Person.address1
$oPerson.address2:=oConnection.data.Person.address2
$oPerson.city:=oConnection.data.Person.city
$oPerson.state:=oConnection.data.Person.state
$oPerson.phone:=oConnection.data.Person.phone
$oPerson.email:=oConnection.data.Person.email
$oPerson.country:=oConnection.data.Person.country
$oPerson.postalCode:=oConnection.data.Person.postalCode

//personObject
If (oConnection.data.personActive="true")
	$oPerson.personObject.active:="Yes"
Else 
	$oPerson.personObject.active:="No"
End if 

If (oConnection.data.personValid="true")
	$oPerson.personObject.valid:="Yes"
Else 
	$oPerson.personObject.valid:="No"
End if 

If (oConnection.data.personDuplicate="true")
	$oPerson.personObject.duplicateName:="Yes"
Else 
	$oPerson.personObject.duplicateName:="No"
End if 

$oPerson.personObject.status:=oConnection.data.Person.personObject.status

$oPerson.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="person")
		
		oConnection.form:="person-list.html"
		oConnection.action:="index"
		
		
	: (oConnection.referer="donation")
		$personName:=$oPerson.lastName+", "+$oPerson.firstName
		oConnection.data.Donation.person:=String:C10($oPerson.personID)
		oConnection.data.Donation.personID:=$oPerson.personID
		Ltg_JS_Send("ltgSelectAddOption('Donation.person','"+String:C10($oPerson.personID)+"','"+$personName+"')")
		Ltg_JS_Send("ltgSelectSetValue('Donation.person','"+String:C10($oPerson.personID)+"')")
		
		oConnection.form:="donations-detail.html"
		oConnection.action:="index"
		
		oConnection.responseType:="javascript"
		
	: (oConnection.referer="order")
		$personName:=$oPerson.lastName+", "+$oPerson.firstName
		oConnection.data.Order.person:=String:C10($oPerson.personID)
		oConnection.data.Order.personID:=$oPerson.personID
		Ltg_JS_Send("ltgSelectAddOption('Order.person','"+String:C10($oPerson.personID)+"','"+$personName+"')")
		Ltg_JS_Send("ltgSelectSetValue('Order.person','"+String:C10($oPerson.personID)+"')")
		
		oConnection.form:="order-detail.html"
		oConnection.action:="index"
		
		oConnection.responseType:="javascript"
		
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
