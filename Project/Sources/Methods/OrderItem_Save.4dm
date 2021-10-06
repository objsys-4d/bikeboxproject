//%attributes = {"shared":true}
C_OBJECT:C1216($oItem)  // ITEM RECORD

// GET THE (PHYSICAL) ORDER ITEM RECORD FROM THE DATASTORE

$oItem:=ds:C1482.Order_Items.get(oConnection.data.Item.Item_ID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oItem=Null:C1517)
	
	$oItem:=ds:C1482.Order_Items.new()
End if 

$oItem.Order_ID:=oConnection.data.Order.Order_ID

$oItem.Product:=oConnection.data.Item.Product

$oItem.Quantity:=Num:C11(oConnection.data.itemQuantity)

$oItem.Rate:=Num:C11(oConnection.data.itemRate)

$oItem.Amount:=$oItem.Quantity*$oItem.Rate

$oItem.save()

Case of 
	: (oConnection.referer="orders")
		
		oConnection.form:="orders-detail.html"
End case 

// SAVE THE ORDER

Order_Save

// DISPLAY ITEMS

OrderItem_DataTable

// WE DON'T NEED TO PUBLISH THE ORDERS DETAIL FORM, SO WE'RE JUST SENDING BACK THE ABOVE JAVASCRIPT

oConnection.responseType:="javascript"
