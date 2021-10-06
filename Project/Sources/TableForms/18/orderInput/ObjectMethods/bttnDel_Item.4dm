
CONFIRM:C162("Are you sure you want to delete this order item record?"; "Yes"; "No")
If (OK=1)
	
	objDeleteListboxElement("orderItemslb")
	
	//refresh listbox data
	$oOrder:=ds:C1482.Order.get(vlOrderUUID)
	Form:C1466.data_list:=$oOrder.Order_OrderItem
	Output_lbInit("orderItemslb")
	
	Form:C1466.order.totalAmount:=Form:C1466.orderItemslb.data.sum("amount")
	Form:C1466.order.totalItems:=Form:C1466.orderItemslb.data.length
	
	OBJECT SET ENABLED:C1123(*; "bttnDel_Item"; False:C215)
End if 