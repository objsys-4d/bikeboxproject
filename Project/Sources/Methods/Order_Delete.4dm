//%attributes = {"shared":true}
C_OBJECT:C1216($oOrder)  // ORDER RECORD

C_OBJECT:C1216($oItems)  // ORDER ITEMS
C_OBJECT:C1216($oItem)  // ORDER ITEM RECORD

C_OBJECT:C1216($oSelected)  // SELECTED RECORD

C_TEXT:C284($txtDialog_Content)  // DIALOG CONTENT

Case of 
		// *** LIST FORM...
		
	: (oConnection.form="orders-list.html")
		
		Case of 
				
			: (oConnection.selected.length=0)
				
				$txtDialog_Content:=Ltg_Str_Localise("%please_select_one_or_more_records_and_try_again")
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('order-delete')")
				
				// DISABLE "DELETE" BUTTON
				
				Ltg_JS_Send("ltgObj('button-delete').attr('disabled',true)")
				
				// UPDATE DIALOG CONTENT
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete-confirm")
				
				$txtDialog_Content:=Ltg_Str_Localise("%delete")+" "+String:C10(oConnection.selected.length)+" "+Ltg_Str_Localise("%orders")+"?"
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('order-delete')")
				
				// ENABLE "DELETE" BUTTON
				
				Ltg_JS_Send("ltgObj('button-delete').attr('disabled',false)")
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete")
				
				For each ($oSelected;oConnection.selected)
					
					$oOrder:=ds:C1482.Orders.get($oSelected.record)
					
					If ($oOrder#Null:C1517)
						
						$oItems:=ds:C1482.Order_Items.query("Order_ID = :1";$oOrder.Order_ID)
						
						For each ($oItem;$oItems)
							
							$oItem.drop()
							
						End for each 
						
						$oOrder.drop()
					End if 
				End for each 
				
				// CLEAR SELECTION
				
				oConnection.selected:=New collection:C1472
				
				// CLOSE CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogClose('order-delete')")
				
		End case 
		
		// *** DETAIL FORM...
		
	: (oConnection.form="orders-detail.html")
		
		Case of 
				
			: (oConnection.action="delete-confirm")
				
				$txtDialog_Content:=Ltg_Str_Localise("%delete")+" "+Ltg_Str_Localise("%order")+"?"
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('order-delete')")
				
				// UPDATE DIALOG CONTENT
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete")
				
				$oOrder:=ds:C1482.Orders.get(oConnection.data.Order.Order_ID)
				
				If ($oOrder#Null:C1517)
					
					$oItems:=ds:C1482.Order_Items.query("Order_ID = :1";$oOrder.Order_ID)
					
					For each ($oItem;$oItems)
						
						$oItem.drop()
						
					End for each 
					
					$oOrder.drop()
				End if 
				
				// PUBLISH THE ORDERS LIST FORM...
				
				oConnection.form:="orders-list.html"
				oConnection.action:="index"
				
		End case 
End case 
