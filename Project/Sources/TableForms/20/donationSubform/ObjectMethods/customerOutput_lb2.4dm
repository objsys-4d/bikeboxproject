Case of 
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29)
		If (vbLoadFlag)  //so this action is only called once (because of On Selection Change)
			
			vbLoadFlag:=False:C215
			vSelPosn:=Form:C1466.customerOutput_lb.curPos
			CALL SUBFORM CONTAINER:C1086(On Load:K2:1)
			
			If (Form:C1466.customerOutput_lb.curPos=0)
				Form:C1466.customer:=Null:C1517
				Form:C1466.cInvoicelb:=Null:C1517
			Else 
				vlCustomerID:=Form:C1466.customerOutput_lb.curItem.CustomerID
				$oCust:=ds:C1482.Customer.query("CustomerID = :1"; vlCustomerID)
				Form:C1466.customer:=$oCust[0]
				Form:C1466.cInvoicelb:=$oCust.customer_invoice
				
				//$oCustInv:=$oCust.customer_invoice
				//CustinvoiceItemslb:=$oCustInv.Item_invcItem
			End if 
			
		Else 
			vbLoadFlag:=True:C214
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		vb_OutCustomer:=True:C214
		CALL SUBFORM CONTAINER:C1086(On Validate:K2:3)
		
End case 
