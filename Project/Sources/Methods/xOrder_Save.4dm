//%attributes = {}
C_OBJECT:C1216($oOrder)  // ORDER RECORD

C_OBJECT:C1216($oItem)  // ORDER ITEM RECORD
C_OBJECT:C1216($oItems)  // ORDER ITEMS SELECTION

C_OBJECT:C1216($oNotification)  // NOTIFICATION

C_OBJECT:C1216($oPrefs)  // PREFERENCES RECORD (FOR ORDER_NUMBER)

// GET THE ORDER ITEMS

$oItems:=ds:C1482.Order_Items.query("Order_ID = :1";oConnection.data.Order.Order_ID)

// GET THE (PHYSICAL) ORDER RECORD FROM THE DATASTORE

$oOrder:=ds:C1482.Orders.get(oConnection.data.Order.Order_ID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oOrder=Null:C1517)
	
	// GET THE APPLICATION PREFERENCES RECORD
	
	$oPrefs:=ds:C1482.Preferences.all().first()
	
	// INCREMENT ORDER NUMBER
	
	$oPrefs.Order_Number:=$oPrefs.Order_Number+1
	
	$oPrefs.save()
	
	// CREATE ORDER RECORD
	
	$oOrder:=ds:C1482.Orders.new()
	
	$oOrder.Order_Number:=String:C10($oPrefs.Order_Number;"SO00000")
	
	// NOTIFY USER OF THE SAVED ORDER NUMBER...
	
	$oNotification:=New object:C1471
	
	$oNotification.type:="success"
	
	$oNotification.icon:="fas fa-save text-white"
	
	$oNotification.description:=Ltg_Str_Escape(Ltg_Str_Localise("%order_saved")+"<br/>"+$oOrder.Order_Number)
	
	Notification_New($oNotification)
End if 

$oOrder.Company_ID:=oConnection.data.Order.Company_ID

$oOrder.Company_Name:=oConnection.data.Order.Company_Name

$oOrder.Contact_ID:=oConnection.data.Order.Contact_ID

$oOrder.Order_Date:=Date:C102(String:C10(oConnection.data.Order.Order_Date;oConnection.session.userDateFormat))

$oOrder.Month:=Month of:C24($oOrder.Order_Date)

$oOrder.Status:=oConnection.data.Order.Status

$oOrder.PO_Reference:=oConnection.data.Order.PO_Reference

$oOrder.Salesperson:=oConnection.data.Order.Salesperson

$oOrder.Subtotal:=$oItems.sum("Amount")

$oOrder.Tax:=$oOrder.Subtotal*0.2

$oOrder.Total:=$oOrder.Subtotal+$oOrder.Tax

$oOrder.save()

// UPDATE ORDER ITEMS...

For each ($oItem;$oItems)
	
	$oItem.Order_ID:=$oOrder.Order_ID
	
	$oItem.Order_Date:=$oOrder.Order_Date
	
	$oItem.Month:=$oOrder.Month
	
	$oItem.save()
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.Order.Order_ID:=$oOrder.Order_ID

oConnection.data.Order.Order_Number:=$oOrder.Order_Number

oConnection.data.orderSubtotal:=String:C10($oOrder.Subtotal;oConnection.session.userCurrency)

oConnection.data.orderTax:=String:C10($oOrder.Tax;oConnection.session.userCurrency)

oConnection.data.orderTotal:=String:C10($oOrder.Total;oConnection.session.userCurrency)
