//%attributes = {"shared":true}
C_OBJECT:C1216($oItem)  // ITEM RECORD

// GET THE (PHYSICAL) ORDER ITEM RECORD FROM THE DATASTORE

$oItem:=ds:C1482.OrderItem.get(oConnection.data.Item.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oItem=Null:C1517)
	
	$oItem:=ds:C1482.OrderItem.new()
End if 

$oItem.orderID:=oConnection.data.Order.orderID

$oItem.orderItemName:=oConnection.data.Item.orderItemName
$oItem.merchID:=oConnection.data.Item.merchID

$oItem.qty:=Num:C11(oConnection.data.itemQuantity)

$oItem.price:=Num:C11(oConnection.data.price)

$oItem.amount:=$oItem.qty*$oItem.price

$oItem.save()


Case of 
	: (oConnection.referer="orders")
		
		oConnection.form:="order-detail.html"
End case 

// SAVE THE ORDER

BBOrder_Save
//Order_Save
// DISPLAY ITEMS

BBOrderItem_DataTable

// WE DON'T NEED TO PUBLISH THE ORDERS DETAIL FORM, SO WE'RE JUST SENDING BACK THE ABOVE JAVASCRIPT

oConnection.responseType:="javascript"
