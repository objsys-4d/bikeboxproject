//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/27/21, 22:41:58
// ----------------------------------------------------
// Method: PersonCompany_ConfirmAdd
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($txtDialog_Content)
If (oConnection.data.Person.company="-1")
	//$txtDialog_Content:="Add Company record?"
	$txtDialog_Content:=Ltg_Str_Localise("%add_company")
	
	//Ltg_JS_Send("ltgDialogOpen('personCompany-modal.html')")
	
	Ltg_JS_Send("ltgDialogOpen('company-add')")
	Ltg_JS_Send("ltgObj('dialog-content2').html('"+$txtDialog_Content+"')")
	oConnection.responseType:="javascript"
	
End if 