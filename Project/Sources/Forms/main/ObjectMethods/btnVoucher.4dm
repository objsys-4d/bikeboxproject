
// ----------------------------------------------------
// User name (OS): Mike Beatty
// Date and time: 08/17/21, 12:50:57
// ----------------------------------------------------
// Method: main.btnvoucher
// Description
// 
//
// Parameters
//
// Change History
// ----------------------------------------------------

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		Form:C1466.voucher_data:=ds:C1482.Voucher.all()
		
		Form:C1466.mainSubform:=New object:C1471("data_list";Form:C1466.voucher_data)
		
		//OBJECT SET SUBFORM(*;"mainSubform";"eventOutput")
		OBJECT SET SUBFORM:C1138(*;"mainSubform";"voucher")
		
		
	Else 
		
		
End case 