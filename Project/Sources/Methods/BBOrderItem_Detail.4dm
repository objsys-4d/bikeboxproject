//%attributes = {"shared":true}
C_OBJECT:C1216($oItem)  // ORDER ITEM RECORD

C_OBJECT:C1216($oProduct)  // PRODUCT

Case of 
		
	: (oConnection.action="new")
		
		$oItem:=ds:C1482.OrderItem.new()
		
		$oItem.orderID:=oConnection.data.Order.orderID
		
		$oItem.orderItemName:=""
		$oItem.qty:=0
		$oItem.price:=0
		$oItem.amount:=0
		
	: (oConnection.action="edit")
		
		$oItem:=ds:C1482.OrderItem.get(oConnection.record)
		
End case 

If ($oItem.orderItemName#"")
	
	$oProduct:=ds:C1482.Merchandise.query("merchID = :1"; $oItem.merchID).first()
	
Else 
	
	$oProduct:=New object:C1471
	
	$oProduct.variant:=""
End if 

oConnection.data.Item:=$oItem  // ORDER ITEM OBJECT

oConnection.data.itemQuantity:=String:C10($oItem.qty; "###,###,##0")  // FORMATTED QUANTITY PROPERTY

oConnection.data.price:=String:C10($oItem.price; oConnection.session.userCurrency)  // FORMATTED RATE PROPERTY

oConnection.data.itemAmount:=String:C10($oItem.amount; oConnection.session.userCurrency)  // FORMATTED AMOUNT PROPERTY
