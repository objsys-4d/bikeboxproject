Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle; vtCustomerName)
		OBJECT SET ENABLED:C1123(*; "bttnDel_Item"; False:C215)
		C_OBJECT:C1216($oOrderPerson)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vtCustomerName:=""
				vt_InputTitle:="Add New Order"
				Form:C1466.order:=ds:C1482.Order.new()
				Form:C1466.order.dateOrder:=Current date:C33(*)
				Form:C1466.order.status:="ACTIVE"
				vlOrderUUID:=Form:C1466.order.UUID
				
			: (vtNavBtnTxt="Edit")
				C_OBJECT:C1216($oOrder; vo_Order)
				vt_InputTitle:="Order Record"
				$oOrder:=ds:C1482.Order.query("UUID = :1"; vlOrderUUID)
				vo_Order:=$oOrder[0]
				Form:C1466.order:=$oOrder[0]
				
				$oOrderPerson:=Form:C1466.order.Order_Person
				If ($oOrderPerson=Null:C1517)
					vtCustomerName:=""
				Else 
					vtCustomerName:=$oOrderPerson.lastName+", "+$oOrderPerson.firstName
				End if 
				//order items
				Form:C1466.data_list:=$oOrder.Order_OrderItem
				Output_lbInit("orderItemslb")
				
		End case 
		
End case 