//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oCompany)  // RELATED COMPANY

C_OBJECT:C1216($oContact)  // CONTACT RECORD
C_OBJECT:C1216($oContacts)  // CONTACTS SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

  // SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="contactsList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="name"
$oSettings.sortField:="Contact_Name"
$oSettings.sortOrder:="asc"

  // INITIALISE FORM SETTINGS

Form_Settings ($oSettings)

  // UPDATE SEARCH...

Ltg_JS_Send ("ltgObj('.searchString').val('"+oUser.contactsList.searchString+"')")

Ltg_JS_Send ("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','name','"+Ltg_Str_Localise ("%name")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','company','"+Ltg_Str_Localise ("%company_name")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','job','"+Ltg_Str_Localise ("%job_title")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','phone','"+Ltg_Str_Localise ("%phone")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','email','"+Ltg_Str_Localise ("%email")+"')")

Ltg_JS_Send ("ltgSelectSetValue('.searchFilter','"+oUser.contactsList.searchFilter+"')")

  // ACTIVE SEARCH?

If (oUser.contactsList.searchString#"")
	
	  // FILTER SEARCH...
	
	Case of 
		: (oUser.contactsList.searchFilter="name")
			
			$oContacts:=ds:C1482.Contacts.query("Contact_Name = :1";"@"+oUser.contactsList.searchString+"@")
			
		: (oUser.contactsList.searchFilter="company")
			
			$oContacts:=ds:C1482.Companies.query("Company_Name =:1";oUser.contactsList.searchString+"@").companyTocontacts
			
		: (oUser.contactsList.searchFilter="job")
			
			$oContacts:=ds:C1482.Contacts.query("Job_Title = :1";oUser.contactsList.searchString+"@")
			
		: (oUser.contactsList.searchFilter="phone")
			
			$oContacts:=ds:C1482.Contacts.query("Phone = :1";"@"+oUser.contactsList.searchString+"@")
			
		: (oUser.contactsList.searchFilter="email")
			
			$oContacts:=ds:C1482.Contacts.query("Email = :1";"@"+oUser.contactsList.searchString+"@")
	End case 
Else 
	
	$oContacts:=ds:C1482.Contacts.all()
End if 

  // *** DATATABLES ***

  // FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oContact;$oContacts)
	
	  // GET THE RELATED COMPANY
	
	$oCompany:=ds:C1482.Companies.get($oContact.Company_ID)
	
	  // RELATED COMPANY NOT FOUND?
	
	If ($oCompany=Null:C1517)
		
		  // DEFAULT COMPANY DATA...
		
		$oCompany:=New object:C1471
		
		$oCompany.Company_ID:=""
		$oCompany.Company_Name:=""
	End if 
	
	  // ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472("";$oContact.Contact_ID;$oCompany.Company_ID;$oContact.Contact_Name;$oCompany.Company_Name;$oContact.Job_Title;$oContact.Phone;$oContact.Email))
	
End for each 

  // UPDATE CONNECTION DATA...

oConnection.data.contactsTotal:=String:C10($oContacts.length;"###,###,###")

oConnection.data.contactsDataTable:=JSON Stringify:C1217($oDataTable)