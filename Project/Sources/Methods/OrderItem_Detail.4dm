//%attributes = {"shared":true}
C_OBJECT:C1216($oItem)  // ORDER ITEM RECORD

C_OBJECT:C1216($oProduct)  // PRODUCT

Case of 
		
	: (oConnection.action="new")
		
		$oItem:=ds:C1482.Order_Items.new()
		
		$oItem.Order_ID:=oConnection.data.Order.Order_ID
		
		$oItem.Product:=""
		$oItem.Quantity:=0
		$oItem.Rate:=0
		$oItem.Amount:=0
		
	: (oConnection.action="edit")
		
		$oItem:=ds:C1482.Order_Items.get(oConnection.record)
		
End case 

If ($oItem.Product#"")
	
	$oProduct:=ds:C1482.Products.query("Product = :1";$oItem.Product).first()
	
Else 
	
	$oProduct:=New object:C1471
	
	$oProduct.Type:=""
	$oProduct.Colour:=""
	$oProduct.Size:=""
End if 

// PRODUCT TYPE DROPDOWN...

Ltg_JS_Send("ltgSelectDeleteOptions('Product.Type')")

Ltg_JS_Send("ltgSelectAddOption('Product.Type','Gloves','"+Ltg_Str_Localise("%gloves")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Type','Hats','"+Ltg_Str_Localise("%hats")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Type','Shoes','"+Ltg_Str_Localise("%shoes")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Type','Socks','"+Ltg_Str_Localise("%socks")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Type','Sunglasses','"+Ltg_Str_Localise("%sunglasses")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Type','Shirts','"+Ltg_Str_Localise("%shirts")+"')")

Ltg_JS_Send("ltgSelectSetValue('Product.Type','"+$oProduct.Type+"')")

// PRODUCT COLOUR DROPDOWN...

Ltg_JS_Send("ltgSelectDeleteOptions('Product.Colour')")

Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Black','"+Ltg_Str_Localise("%black")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Brown','"+Ltg_Str_Localise("%brown")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Green','"+Ltg_Str_Localise("%green")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Khaki','"+Ltg_Str_Localise("%khaki")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Navy','"+Ltg_Str_Localise("%navy")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Colour','Purple','"+Ltg_Str_Localise("%purple")+"')")

Ltg_JS_Send("ltgSelectSetValue('Product.Colour','"+$oProduct.Colour+"')")

// PRODUCT SIZE DROPDOWN...

Ltg_JS_Send("ltgSelectDeleteOptions('Product.Size')")

Ltg_JS_Send("ltgSelectAddOption('Product.Size','Small','"+Ltg_Str_Localise("%small")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Size','Medium','"+Ltg_Str_Localise("%medium")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Size','Large','"+Ltg_Str_Localise("%large")+"')")
Ltg_JS_Send("ltgSelectAddOption('Product.Size','Extra-Large','"+Ltg_Str_Localise("%extra-large")+"')")

Ltg_JS_Send("ltgSelectSetValue('Product.Size','"+$oProduct.Size+"')")

// UPDATE CONNECTION DATA...

oConnection.data.Item:=$oItem  // ORDER ITEM OBJECT

oConnection.data.itemQuantity:=String:C10($oItem.Quantity;"###,###,##0")  // FORMATTED QUANTITY PROPERTY

oConnection.data.itemRate:=String:C10($oItem.Rate;oConnection.session.userCurrency)  // FORMATTED RATE PROPERTY

oConnection.data.itemAmount:=String:C10($oItem.Amount;oConnection.session.userCurrency)  // FORMATTED AMOUNT PROPERTY
