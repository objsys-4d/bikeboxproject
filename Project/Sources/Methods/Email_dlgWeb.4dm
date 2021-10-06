//%attributes = {"shared":true}
// Project Method: Contact_Detail
// Example: Email_dlgWeb
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Display a [Contacts] record

C_OBJECT:C1216($oEmail)  // email RECORD
C_TEXT:C284($txtEml_ID)

$txtEml_ID:=Ltg_URL_GetParam("email")

Case of 
	: (oConnection.referer="person")  //(oConnection.action="new")
		$oEmail:=ds:C1482.Person.get(oConnection.data.Person.UUID)  //(oConnection.record)
		
	: (oConnection.referer="company")
		$oEmail:=ds:C1482.Company.get(oConnection.data.Company.UUID)
		
End case 

oConnection.data.email:=$oEmail  // CONTACT