//%attributes = {"shared":true}
C_OBJECT:C1216($oContact)  // CONTACT RECORD

// GET THE (PHYSICAL) CONTACT RECORD FROM THE DATASTORE

$oContact:=ds:C1482.Contacts.get(oConnection.data.Contact.Contact_ID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oContact=Null:C1517)
	
	$oContact:=ds:C1482.Contacts.new()
	
End if 

$oContact.Company_ID:=oConnection.data.Contact.Company_ID
$oContact.First_Name:=oConnection.data.Contact.First_Name
$oContact.Last_Name:=oConnection.data.Contact.Last_Name
$oContact.Job_Title:=oConnection.data.Contact.Job_Title
$oContact.Phone:=oConnection.data.Contact.Phone
$oContact.Email:=oConnection.data.Contact.Email

$oContact.Contact_Name:=$oContact.First_Name+" "+$oContact.Last_Name

$oContact.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="companies")
		
		oConnection.form:="companies-detail.html"
		oConnection.action:="edit"
		oConnection.record:=$oContact.Company_ID
		
		Ltg_JS_Send("ltgTabSetActive('tabs-contacts-tab')")
		
	: (oConnection.referer="contacts")
		
		oConnection.form:="contacts-list.html"
		oConnection.action:="index"
End case 

