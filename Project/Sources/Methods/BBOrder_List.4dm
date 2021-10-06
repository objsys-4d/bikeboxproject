//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oBBOrd)  // Order RECORD
C_OBJECT:C1216($oBBOrder)  // Order SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="orderList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="nameName"
$oSettings.sortField:="dateOrder"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.orderList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','nameName','"+Ltg_Str_Localise("%nameName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','address','"+Ltg_Str_Localise("%address")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','dateOrder','"+Ltg_Str_Localise("%dateOrder")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.orderList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('companyPageSize','pageSize-"+String:C10(oUser.orderList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.orderList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.orderList.searchFilter="nameName")
			
			$objPerson:=ds:C1482.Person.query("lastName = :1 or firstName = :1"; $text)
			$oBBOrder:=$objPerson.Person_Order
			
			//$oBBOrder:=ds.Order.query("companyName = :1"; "@"+oUser.orderList.searchString+"@")
			
		: (oUser.orderList.searchFilter="address")
			
			$oBBOrder:=ds:C1482.Order.query("address = :1 or city = :1 or state = :1"; "@"+oUser.orderList.searchString+"@")
			
		: (oUser.orderList.searchFilter="dateOrder")
			
			$oBBOrder:=ds:C1482.Order.query("dateOrder = :1"; Date:C102(oUser.orderList.searchString))
			
	End case 
Else 
	
	$oBBOrder:=ds:C1482.Order.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.orderList.pageCount:=Abs:C99(Int:C8(-($oBBOrder.length/(oUser.orderList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472
C_TEXT:C284($addr; $name)
C_OBJECT:C1216($ordPerson)
For each ($oBBOrd; $oBBOrder)
	
	// ADD TO DATATABLES (JSON)
	$addr:=$oBBOrd.address
	If ($oBBOrd.city#"")
		$addr:=$addr+", "+$oBBOrd.city
	End if 
	If ($oBBOrd.state#"")
		$addr:=$addr+", "+$oBBOrd.state
	End if 
	$ordPerson:=$oBBOrd.order_Person
	If ($ordPerson=Null:C1517)
		$name:=""
	Else 
		$name:=$ordPerson.lastName+", "+$ordPerson.firstName
	End if 
	$oDataTable.push(New collection:C1472(""; $oBBOrd.UUID; $oBBOrd.dateOrder; $name; $addr; $oBBOrd.totalItems; String:C10($oBBOrd.totalAmount; "$###,###,##0.00"); $oBBOrd.status))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.orderTotal:=String:C10($oBBOrder.length; "###,###,###")

oConnection.data.orderDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.orderPageNumber:=String:C10(oUser.orderList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oBBOrder

