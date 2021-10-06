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
	$oProduct.Type:=""
	
End if 

// PRODUCT TYPE DROPDOWN...

Ltg_JS_Send("ltgSelectDeleteOptions('Product.Type')")
C_OBJECT:C1216($oMrc; $oMerch)
$oMerch:=ds:C1482.Merchandise.all()

For each ($oMrc; $oMerch)
	Ltg_JS_Send("ltgSelectAddOption('Product.Type','"+String:C10($oMrc.merchID)+"','"+$oMrc.merchName+"')")
End for each 

//Ltg_JS_Send("ltgSelectAddOption('Product.Type','gloves','"+Ltg_Str_Localise("%gloves")+"')")
//Ltg_JS_Send("ltgSelectAddOption('Product.Type','hats','"+Ltg_Str_Localise("%hats")+"')")
//Ltg_JS_Send("ltgSelectAddOption('Product.Type','shoes','"+Ltg_Str_Localise("%shoes")+"')")
//Ltg_JS_Send("ltgSelectAddOption('Product.Type','socks','"+Ltg_Str_Localise("%socks")+"')")
//Ltg_JS_Send("ltgSelectAddOption('Product.Type','sunglasses','"+Ltg_Str_Localise("%sunglasses")+"')")
//Ltg_JS_Send("ltgSelectAddOption('Product.Type','shirts','"+Ltg_Str_Localise("%shirts")+"')")

Ltg_JS_Send("ltgSelectSetValue('Product.Type','"+$oProduct.Type+"')")

oConnection.data.Item:=$oItem  // ORDER ITEM OBJECT

oConnection.data.itemQuantity:=String:C10($oItem.qty; "###,###,##0")  // FORMATTED QUANTITY PROPERTY

oConnection.data.price:=String:C10($oItem.price; oConnection.session.userCurrency)  // FORMATTED RATE PROPERTY

oConnection.data.itemAmount:=String:C10($oItem.amount; oConnection.session.userCurrency)  // FORMATTED AMOUNT PROPERTY
