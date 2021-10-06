//%attributes = {"shared":true}
C_OBJECT:C1216($oMerch)  // COMPANY RECORD

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oMerch:=ds:C1482.Merchandise.get(oConnection.data.Merchandise.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oMerch=Null:C1517)
	
	$oMerch:=ds:C1482.Merchandise.new()
	
End if 

$oMerch.merchName:=oConnection.data.Merchandise.merchName
$oMerch.price:=oConnection.data.Merchandise.price
$oMerch.stock:=oConnection.data.Merchandise.stock
$oMerch.variant:=oConnection.data.Merchandise.variant
$oMerch.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="merch")
		
		oConnection.form:="merch-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
