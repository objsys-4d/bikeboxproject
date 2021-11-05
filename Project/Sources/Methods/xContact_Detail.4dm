//%attributes = {"shared":true}
  // Project Method: Contact_Detail
  // Example: Contact_Detail
  // ---------------------------------------------------
  // Version: 5.0
  // ---------------------------------------------------
  // Description: Display a [Contacts] record

C_OBJECT:C1216($oContact)  // CONTACT RECORD
C_OBJECT:C1216($oCompany)  // RELATED COMPANY RECORD

Case of 
		
	: (oConnection.action="new")
		
		$oContact:=ds:C1482.Contacts.new()
		
		  // COMPANY_ID PASSED AS RECORD PARAMETER?
		
		If (oConnection.record#"")
			
			$oContact.Company_ID:=oConnection.record
		End if 
		
		  // UPDATE LIGHTNING WITH THE ID OF THE NEW CONTACT RECORD
		
		oConnection.record:=$Contact.Contact_ID
		
	: (oConnection.action="edit")
		
		$oContact:=ds:C1482.Contacts.get(oConnection.record)
		
End case 

  // JOB TITLE DROPDOWN...

Ltg_JS_Send ("ltgSelectDeleteOptions('Contact.Job_Title')")

Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Account Manager','Account Manager')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Assistant','Assistant')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Clerk','Clerk')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Director','Director')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Owner','Owner')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Sales Representative','Sales Representative')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Secretary','Secretary')")
Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Technician','Technician')")

Ltg_JS_Send ("ltgSelectSetValue('Contact.Job_Title','"+$oContact.Job_Title+"')")

  // UPDATE CONNECTION DATA...

oConnection.data.Contact:=$oContact  // CONTACT

  // LOAD RELATED COMPANY...

oConnection.data.companyName:=""

$oCompany:=ds:C1482.Companies.get($oContact.Company_ID)

If ($oCompany#Null:C1517)
	
	oConnection.data.companyName:=$oCompany.Company_Name  // COMPANY NAME
End if 
