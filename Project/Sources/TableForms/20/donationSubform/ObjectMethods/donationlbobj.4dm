Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		Form:C1466.invc:=curItem
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		vb_EvtInvoice:=True:C214
		vlInvoiceID:=Form:C1466.invc.InvoiceID
		CALL SUBFORM CONTAINER:C1086(On Validate:K2:3)
		
End case 