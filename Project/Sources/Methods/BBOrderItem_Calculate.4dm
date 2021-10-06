//%attributes = {"shared":true}

C_OBJECT:C1216($oProduct)

// MATCH THE PRODUCT
$merchID:=Num:C11(oConnection.data.Product.Type)
$oProduct:=ds:C1482.Merchandise.query("merchID = :1"; $merchID).first()

// SINGLE PRODUCT MATCH?

If ($oProduct#Null:C1517)
	
	// UPDATE ITEM PRODUCT
	If (oConnection.form="order-item-add.html") & (oConnection.data.itemQuantity="0")
		oConnection.data.itemQuantity:="1"
		oConnection.data.price:=String:C10($oProduct.price; oConnection.session.userCurrency)
	End if 
	oConnection.data.Item.orderItemName:=$oProduct.merchName
	
	// FORMAT AMOUNTS...
	
	oConnection.data.itemAmount:=String:C10(Num:C11(oConnection.data.itemQuantity)*$oProduct.price; oConnection.session.userCurrency)  // FORMATTED AMOUNT PROPERTY
	
	oConnection.data.itemQuantity:=String:C10(Num:C11(oConnection.data.itemQuantity); "###,###,##0")  // FORMATTED QUANTITY PROPERTY
	
	oConnection.data.itemRate:=String:C10($oProduct.price; oConnection.session.userCurrency)  // FORMATTED RATE PROPERTY
	
End if 
