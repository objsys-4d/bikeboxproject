//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 00:06:17
// ----------------------------------------------------
// Method: DonationPerson_Modal
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($oPersonRec)
C_LONGINT:C283($personID)


Case of 
	: (oConnection.data.Donation.person="0")
		//should just close the modal or not call the modal
		$oPersonRec:=ds:C1482.Person.all()
		
		
	: (oConnection.data.Donation.person="-1")
		//new record
		$oPersonRec:=New object:C1471
		//$oCompanyRec:=ds.Company.all()
		//$oCompanyRec:=ds.Company.new()
		//oConnection.data.Company:=$oCompanyRec
		
	Else 
		$personID:=Num:C11(oConnection.data.Donation.person)
		$oPersonRec:=ds:C1482.Person.query("personID = :1"; $personID)
		//oConnection.data.Company:=$oCompanyRec  //[0]  <--- we ommit [0] for the dialog to not display.
		
End case 
oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE
oConnection.data.Person:=$oPersonRec
