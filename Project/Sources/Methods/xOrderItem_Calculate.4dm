//%attributes = {"shared":true}

C_OBJECT:C1216($oProduct)

  // MATCH THE PRODUCT

$oProduct:=ds:C1482.Products.query("Type = :1 and Colour = :2 and Size = :3";oConnection.data.Product.Type;oConnection.data.Product.Colour;oConnection.data.Product.Size).first()

  // SINGLE PRODUCT MATCH?

If ($oProduct#Null:C1517)
	
	  // UPDATE ITEM PRODUCT
	
	oConnection.data.Item.Product:=$oProduct.Product
	
	  // FORMAT AMOUNTS...
	
	oConnection.data.itemAmount:=String:C10(Num:C11(oConnection.data.itemQuantity)*$oProduct.Rate;oConnection.session.userCurrency)  // FORMATTED AMOUNT PROPERTY
	
	oConnection.data.itemQuantity:=String:C10(Num:C11(oConnection.data.itemQuantity);"###,###,##0")  // FORMATTED QUANTITY PROPERTY
	
	oConnection.data.itemRate:=String:C10($oProduct.Rate;oConnection.session.userCurrency)  // FORMATTED RATE PROPERTY
End if 
