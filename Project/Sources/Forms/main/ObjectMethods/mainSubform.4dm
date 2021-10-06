Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(vSelPosn)
		//ObjForm_SubformLoad(vtActiveBt)
		
		OBJECT SET ENABLED:C1123(*; "navBtn_S@"; vSelPosn#0)
		
		
	: (Form event code:C388=On Validate:K2:3)
		
		Case of 
			: (vb_EvtInvoice)
				vb_EvtInvoice:=False:C215
				vtNavBtnTxt:="Edit"
				
				vt_ActBtOrig:=vtActiveBt
				vtActiveBt:="Invoice"
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Voucher:10]; "invoiceInput")
				OBJECT SET VISIBLE:C603(*; "navBtn_@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "actBtn_@"; True:C214)
				
			: (vb_OutPerson) | (vb_OutCompany) | (vb_OutMerch) | (vb_OutEvent) | (vb_OutOrder)
				vb_OutPerson:=False:C215
				vb_OutCompany:=False:C215
				vb_OutMerch:=False:C215
				vb_OutEvent:=False:C215
				vb_OutOrder:=False:C215
				ObjForm_NavBtn(vtActiveBt; "Edit")
				
				
		End case 
		//ObjForm_SubformLoad("Add Customer")  //vtActiveBt)"
		
End case 