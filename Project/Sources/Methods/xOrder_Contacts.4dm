//%attributes = {"shared":true}
C_TEXT:C284($1)  // COMPANY_ID

C_OBJECT:C1216($oContact)
C_OBJECT:C1216($oContacts)

  // DELETE CURRENT DROPDOWN OPTIONS

Ltg_JS_Send ("ltgSelectDeleteOptions('Order.Contact_ID')")

$oContacts:=ds:C1482.Contacts.query("Company_ID = :1";$1).orderBy("Last_Name asc")

If ($oContacts#Null:C1517)
	
	  // BUILD NEW DROPDOWN OPTIONS...
	
	For each ($oContact;$oContacts)
		
		Ltg_JS_Send ("ltgSelectAddOption('Order.Contact_ID','"+$oContact.Contact_ID+"','"+$oContact.Contact_Name+"')")
		
	End for each 
End if 

