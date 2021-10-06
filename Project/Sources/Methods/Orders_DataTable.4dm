//%attributes = {"shared":true}
C_OBJECT:C1216($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oOrder)  // CURRENT ORDER
C_OBJECT:C1216($oOrders)  // ORDERS SELECTION

C_TEXT:C284($txtOrder_By)  // ORDER BY

  // NOTE: DATATABLES IS USING THE SERVER SIDE OPTION (serverSide: true)

  // NOTE: THE DATATABLES JSON REQUEST VALUES ARE OBTAINED VIA THE CONNECTION.DATA

  // SET CURRENT ORDER BY CRITERIA

$txtOrder_By:=oConnection.data["columns["+oConnection.data["order[0][column]"]+"][name]"]+" "+oConnection.data["order[0][dir]"]

  // ACTIVE SEARCH?

If (oUser.ordersList.searchString#"")
	
	  // FILTER SEARCH...
	
	Case of 
		: (oUser.ordersList.searchFilter="number")
			
			$oOrders:=ds:C1482.Orders.query("Order_Number = :1";"@"+oUser.ordersList.searchString+"@").orderBy($txtOrder_By)
			
		: (oUser.ordersList.searchFilter="company")
			
			$oOrders:=ds:C1482.Orders.query("Company_Name = :1";oUser.ordersList.searchString+"@").orderBy($txtOrder_By)
	End case 
Else 
	
	$oOrders:=ds:C1482.Orders.all().orderBy($txtOrder_By)
End if 

  // *** DATATABLES ***

$oDataTable:=New object:C1471

  // TOTAL RECORDS IN SELECTION

$oDataTable.recordsTotal:=$oOrders.length
$oDataTable.recordsFiltered:=$oOrders.length

  // SELECT THE CURRENT PAGE DATA ONLY

$oOrders:=$oOrders.slice(Num:C11(oConnection.data.start);Num:C11(oConnection.data.start)+Num:C11(oConnection.data.length))

$oDataTable.data:=New collection:C1472

For each ($oOrder;$oOrders)
	
	  // ADD TO DATATABLES (JSON)
	
	$oDataTable.data.push(New collection:C1472("";$oOrder.Order_ID;$oOrder.Company_ID;$oOrder.Order_Number;String:C10($oOrder.Order_Date;Internal date short:K1:7);$oOrder.Company_Name;$oOrder.PO_Reference;Ltg_Str_Localise ("%"+$oOrder.Status);String:C10($oOrder.Total;oConnection.session.userCurrency)))
	
End for each 

Ltg_HTTP_SendText (JSON Stringify:C1217($oDataTable))
