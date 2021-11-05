//%attributes = {"shared":true}
C_OBJECT:C1216($oOrder)  // ORDER RECORD

// CREATE THE ORDER OBJECT FOR THE SELECTED RECORD...

// NOTE: THIS OBJECT WILL BE ADDED TO THE CONNECTION.DATA

Case of 
		
	: (oConnection.action="new")  // NEW RECORD
		
		// CREATE ORDER RECORD...
		
		$oOrder:=ds:C1482.Orders.new()
		
		$oOrder.Order_Number:=""
		
		$oOrder.Company_ID:=""
		
		$oOrder.Contact_ID:=""
		
		$oOrder.Order_Date:=Current date:C33(*)
		
		$oOrder.Salesperson:="mhammond"
		
		$oOrder.Status:="Processing"
		
		$oOrder.Subtotal:=0
		
		$oOrder.Tax:=0
		
		$oOrder.Total:=0
		
	: (oConnection.action="edit")  // EDIT RECORD
		
		$oOrder:=ds:C1482.Orders.get(oConnection.record)
End case 

// BUILD DROPDOWN LIST OF AVAILABLE COMPANY CONTACTS...

xOrder_Contacts($oOrder.Company_ID)

// SET THE STATUS DROPDOWN

Ltg_JS_Send("ltgSelectSetValue('Order.Status','"+$oOrder.Status+"')")

// SET THE SALESPERSON DROPDOWN

Ltg_JS_Send("ltgSelectSetValue('Order.Salesperson','"+$oOrder.Salesperson+"')")

// SET THE CONTACT NAME DROPDOWN

Ltg_JS_Send("ltgSelectSetValue('Order.Contact_ID','"+$oOrder.Contact_ID+"')")

// UPDATE CONNECTION DATA...

oConnection.data.Order:=$oOrder  // ORDER RECORD

oConnection.data.orderSubtotal:=String:C10($oOrder.Subtotal; oConnection.session.userCurrency)

oConnection.data.orderTax:=String:C10($oOrder.Tax; oConnection.session.userCurrency)

oConnection.data.orderTotal:=String:C10($oOrder.Total; oConnection.session.userCurrency)

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

// CREATE ORDER ITEMS DATATABLE

OrderItem_DataTable
