Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(vSelPosn; vlCustomerID; vlItemID; vlSupplierID; vlInvoiceID)
		C_OBJECT:C1216(CustinvoiceItemslb; Custinvoicelb)
		C_BOOLEAN:C305(vb_OutCompany; vb_OutPerson; vb_OutMerch; vb_OutEvent; vb_OutOrder)
		C_TEXT:C284(vt_ActBtOrig; vtNavBtnTxt)
		vb_EvtInvoice:=False:C215
		vb_OutCompany:=False:C215
		vb_OutPerson:=False:C215
		vb_OutMerch:=False:C215
		vb_OutEvent:=False:C215
		vb_OutOrder:=False:C215
		
		vt_ActBtOrig:=""
		
		OBJECT SET ENABLED:C1123(*; "navBtn@"; vSelPosn#0)
		
		C_TEXT:C284(wa_url)
		wa_url:="https://www.google.com/maps"
		vSelPosn:=0
End case 