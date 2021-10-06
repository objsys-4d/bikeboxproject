//%attributes = {"shared":true}
C_OBJECT:C1216($oOrder)  // ORDER RECORD

// CREATE THE ORDER OBJECT FOR THE SELECTED RECORD...

// NOTE: THIS OBJECT WILL BE ADDED TO THE CONNECTION.DATA

Case of 
		
	: (oConnection.action="new")  // NEW RECORD
		
		// CREATE ORDER RECORD...
		
		$oOrder:=ds:C1482.Order.new()
		
		//$oOrder.personID:=""
		
		//$oOrder.Contact_ID:=""
		
		$oOrder.dateOrder:=Current date:C33(*)
		
		//$oOrder.Salesperson:="mhammond"
		
		$oOrder.status:="Processing"
		
		$oOrder.totalAmount:=0
		
		//$oOrder.Tax:=0
		
		//$oOrder.Total:=0
		
	: (oConnection.action="edit")  // EDIT RECORD
		
		$oOrder:=ds:C1482.Order.get(oConnection.record)
End case 

//Person pulldown
C_OBJECT:C1216($oPsn)
If ($oOrder.personID=0)
	$oPsn:=New object:C1471
	$oPsn.personID:=0
Else 
	$oPsn:=ds:C1482.Person.query("personID = :1"; $oOrder.personID).first()
	If ($oPsn=Null:C1517)
		$oPsn:=New object:C1471
		$oPsn.personID:=0
	End if 
End if 
//Person Name pulldown
C_TEXT:C284($personName)
Ltg_JS_Send("ltgSelectDeleteOptions('Order.person')")
C_OBJECT:C1216($oPer; $oPerson)
$oPerson:=ds:C1482.Person.all().orderBy("lastName asc")
Ltg_JS_Send("ltgSelectAddOption('Order.person','0','"+$personName+"')")  //to clear
Ltg_JS_Send("ltgSelectAddOption('Order.person','-1','Add person record...')")  //to clear
For each ($oPer; $oPerson)
	$personName:=$oPer.lastName+", "+$oPer.firstName
	Ltg_JS_Send("ltgSelectAddOption('Order.person','"+String:C10($oPer.personID)+"','"+$personName+"')")
End for each 
Ltg_JS_Send("ltgSelectSetValue('Order.person','"+String:C10($oPsn.personID)+"')")


// SET THE STATUS DROPDOWN
ARRAY TEXT:C222($arOrderStatus; 0)
LIST TO ARRAY:C288("Order Status"; $arOrderStatus)
$s:=Find in array:C230($arOrderStatus; $oOrder.status)
If ($s=-1)
	Ltg_JS_Send("ltgSelectSetValue('Order.status','')")
Else 
	Ltg_JS_Send("ltgSelectSetValue('Order.status','"+$arOrderStatus{$s}+"')")
End if 

State_ltgPulldown("Order"; $oOrder.state)


// UPDATE CONNECTION DATA...

C_OBJECT:C1216($oOrderPerson)
C_TEXT:C284($personName)
$oOrderPerson:=$oOrder.order_Person
If ($oOrderPerson=Null:C1517)
	$personName:=""
Else 
	$personName:=$oOrderPerson.lastName+", "+$oOrderPerson.firstName
End if 
oConnection.data.personName:=$personName



oConnection.data.Order:=$oOrder  // ORDER RECORD

oConnection.data.orderSubtotal:=String:C10($oOrder.totalAmount; oConnection.session.userCurrency)
oConnection.data.totalAmount:=String:C10($oOrder.totalAmount; oConnection.session.userCurrency)

//oConnection.data.orderTax:=String($oOrder.Tax; oConnection.session.userCurrency)

//oConnection.data.orderTotal:=String($oOrder.Total; oConnection.session.userCurrency)

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

// CREATE ORDER ITEMS DATATABLE

//OrderItem_DataTable
BBOrderItem_DataTable