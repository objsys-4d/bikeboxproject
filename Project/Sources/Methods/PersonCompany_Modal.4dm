//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/24/21, 15:59:38
// ----------------------------------------------------
// Method: PersonCompany_Modal
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($oCompanyRec)
C_LONGINT:C283($companyID)


Case of 
	: (oConnection.data.Person.company="0")
		//should just close the modal
		$oCompanyRec:=ds:C1482.Company.all()
		
		
	: (oConnection.data.Person.company="-1")
		//new record
		$oCompanyRec:=New object:C1471
		//$oCompanyRec:=ds.Company.all()
		//$oCompanyRec:=ds.Company.new()
		//oConnection.data.Company:=$oCompanyRec
		
	Else 
		$companyID:=Num:C11(oConnection.data.Person.company)
		$oCompanyRec:=ds:C1482.Company.query("companyID = :1"; $companyID)
		//oConnection.data.Company:=$oCompanyRec[0]  //<---we put [0] for the dialog to display the record.
		
End case 
oConnection.data.Company:=$oCompanyRec

