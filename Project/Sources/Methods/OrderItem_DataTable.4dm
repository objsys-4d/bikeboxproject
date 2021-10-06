//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)

C_OBJECT:C1216($oItem)  // CURRENT ORDER ITEM
C_OBJECT:C1216($oItems)  // ORDER ITEM SELECTION

C_OBJECT:C1216($oProduct)  // PRODUCT RECORD

$oItems:=ds:C1482.Order_Items.query("Order_ID = :1";oConnection.data.Order.Order_ID).orderBy("Product asc")

$oDataTable:=New collection:C1472

For each ($oItem;$oItems)
	
	// GET THE PRODUCT RECORD
	
	$oProduct:=ds:C1482.Products.query("Product = :1";$oItem.Product).first()
	
	If ($oProduct#Null:C1517)
		
		// CREATE A LOCALISED DESCRIPTION OF THE PRODUCT 
		
		$txtDescription:=Ltg_Str_Localise("%"+$oProduct.Type)+", "+Ltg_Str_Localise("%"+$oProduct.Colour)+", "+Ltg_Str_Localise("%"+$oProduct.Size)
		
	Else 
		
		$txtDescription:=""
	End if 
	
	// ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472("";$oItem.Item_ID;$oItem.Product;$txtDescription;$oItem.Quantity;String:C10($oItem.Rate;oConnection.session.userCurrency);String:C10($oItem.Amount;oConnection.session.userCurrency);""))
	
End for each 

// CLEAR THE ORDER ITEMS DATATABLE

Ltg_JS_Send("ltgObj('items').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE

If ($oDataTable.length>0)
	
	Ltg_JS_Send("ltgObj('items').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
	
End if 
