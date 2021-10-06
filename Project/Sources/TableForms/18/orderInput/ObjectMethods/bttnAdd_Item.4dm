C_TEXT:C284(vSelName)
C_LONGINT:C283(vSelID)
GEN_Dlg_CenterWindow(->[Merchandise:17]; "merchList"; "Order -> Add Items")
If (OK=1)
	C_OBJECT:C1216($oOrdItem)
	
	Form:C1466.order.save()  //save the header record
	
	$oOrdItem:=ds:C1482.OrderItem.new()
	$oOrdItem.merchID:=vSelID
	$oOrdItem.orderID:=Form:C1466.order.orderID
	$oOrdItem.orderItemName:=vSelName
	$oOrdItem.price:=vSelPrice
	$oOrdItem.qty:=1
	$oOrdItem.amount:=vSelPrice
	$oOrdItem.save()
	
	
	//refresh listbox data
	$oOrder:=ds:C1482.Order.get(vlOrderUUID)
	Form:C1466.data_list:=$oOrder.Order_OrderItem
	Output_lbInit("orderItemslb")
	
	Form:C1466.order.totalAmount:=Form:C1466.orderItemslb.data.sum("amount")
	Form:C1466.order.totalItems:=Form:C1466.orderItemslb.data.length
End if 
