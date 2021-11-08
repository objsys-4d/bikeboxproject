//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oContact)  // CURRENT CONTACT
C_OBJECT:C1216($oContacts)  // CONTACTS SELECTION

$oContacts:=ds:C1482.Contacts.query("Company_ID = :1";oConnection.data.Company.Company_ID)

  // *** DATATABLES ***

$oDataTable:=New collection:C1472

For each ($oContact;$oContacts)
	
	  // ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472($oContact.Contact_ID;$oContact.Contact_Name;$oContact.Job_Title;$oContact.Phone;$oContact.Email))
	
End for each 

  // UPDATE CONNECTION DATA...

oConnection.data.contactsDataTable:=JSON Stringify:C1217($oDataTable)