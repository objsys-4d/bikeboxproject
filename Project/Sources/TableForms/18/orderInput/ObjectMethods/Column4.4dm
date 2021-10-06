Case of 
	: (Form event code:C388=On Data Change:K2:15)
		//This.amount:=This.qty*This.price
		//Form.orderItemslb[curPos-1].amount:=Form.orderItemslb[curPos-1].qty*Form.orderItemslb[curPos-1].price
		//curItem.amount:=curItem.qty*curItem.price
		
		//update order items
		C_OBJECT:C1216($oOrderItem)
		$oOrderItem:=ds:C1482.OrderItem.get(This:C1470.UUID)
		$oOrderItem.amount:=$oOrderItem.qty*$oOrderItem.price
		$oOrderItem.save()
		
		//update order total amount
		Form:C1466.order.totalAmount:=Form:C1466.orderItemslb.data.sum("amount")
		
		//Form.orderItemslb.save()
		//vo_Order.reload()
		//Form.orderItemslb:=vo_Order.Order_OrderItem
		//Form.order.totalItems:=Form.orderItemslb.length
		//Form.order.totalAmount:=Form.orderItemslb.sum("amount")
End case 