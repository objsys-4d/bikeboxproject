//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/16/21, 21:06:51
// ----------------------------------------------------
// Method: BBOrderItem_DataTable
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($oDataTable)

C_OBJECT:C1216($oItem)  // CURRENT ORDER ITEM
C_OBJECT:C1216($oItems)  // ORDER ITEM SELECTION

C_OBJECT:C1216($oProduct)  // PRODUCT RECORD

$oItems:=ds:C1482.OrderItem.query("orderID = :1"; oConnection.data.Order.orderID).orderBy("orderItemName asc")

$oDataTable:=New collection:C1472

For each ($oItem; $oItems)
	
	// GET THE PRODUCT RECORD
	
	$oProduct:=ds:C1482.Merchandise.query("merchID = :1"; $oItem.merchID).first()
	
	If ($oProduct#Null:C1517)
		
		// CREATE A LOCALISED DESCRIPTION OF THE PRODUCT 
		
		$txtDescription:=Ltg_Str_Localise("%"+$oProduct.variant)
		
	Else 
		
		$txtDescription:=""
	End if 
	
	// ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472(""; $oItem.UUID; $oItem.orderItemName; String:C10($oItem.price; oConnection.session.userCurrency); $oItem.qty; String:C10($oItem.amount; oConnection.session.userCurrency); ""))
	
End for each 

// CLEAR THE ORDER ITEMS DATATABLE

Ltg_JS_Send("ltgObj('items').dataTable().fnClearTable()")

// UPDATE THE ORDER ITEMS DATATABLE

If ($oDataTable.length>0)
	
	Ltg_JS_Send("ltgObj('items').dataTable().fnAddData(JSON.parse('"+JSON Stringify:C1217($oDataTable)+"'))")
	
End if 

