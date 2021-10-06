//%attributes = {"shared":true}
C_OBJECT:C1216($oOrder; $oOrdItem)  // ORDER RECORD

// GET THE (PHYSICAL) ORDER RECORD FROM THE DATASTORE

$oOrder:=ds:C1482.Order.get(oConnection.data.Order.UUID)
//$oOrder:=ds.Order.query("UUID = :1"; oConnection.data.Order.UUID)
$oOrdItem:=$oOrder.Order_OrderItem
If ($oOrdItem=Null:C1517)
	$nbItems:=0
	oConnection.data.Order.totalAmount:=0
Else 
	$nbItems:=$oOrdItem.length
	oConnection.data.Order.totalAmount:=$oOrdItem.sum("amount")
End if 
oConnection.data.totalAmount:=String:C10(oConnection.data.Order.totalAmount; oConnection.session.userCurrency)
// NEW RECORD TO BE SAVED FROM DATA?

If ($oOrder=Null:C1517)
	
	$oOrder:=ds:C1482.Order.new()
	
End if 

$oOrder.dateOrder:=Date:C102(oConnection.data.Order.dateOrder)
$oOrder.status:=oConnection.data.Order.status
$oOrder.personID:=oConnection.data.Order.person
$oOrder.address:=oConnection.data.Order.address
$oOrder.city:=oConnection.data.Order.city
$oOrder.state:=oConnection.data.Order.state
$oOrder.zip:=oConnection.data.Order.postalCode
$oOrder.phone1:=oConnection.data.Order.phone1
$oOrder.phone2:=oConnection.data.Order.phone2
$oOrder.email:=oConnection.data.Order.email
$oOrder.totalItems:=$nbItems
$oOrder.totalAmount:=oConnection.data.Order.totalAmount
$oOrder.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="order")
		
		oConnection.form:="order-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
