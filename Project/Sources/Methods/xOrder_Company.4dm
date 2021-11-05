//%attributes = {"shared":true}
C_TEXT:C284($1)

C_OBJECT:C1216($oCompany)
C_OBJECT:C1216($oCompanies)

C_TEXT:C284($txtQuery)

C_TEXT:C284($txtHTML)

// A SIMPLE AUTOCOMPLETE METHOD, REFER TO APP.JS FOR THE CLIENT SIDE FUNCTIONS

$txtQuery:=$1

If ($txtQuery#"")
	
	$oCompanies:=ds:C1482.Companies.query("Company_Name = :1"; $txtQuery+"@").orderBy("Company_Name asc")
	
	Case of 
			
			// MATCHED RECORD?
			
		: ($oCompanies.length=1)
			
			oConnection.data.Order.Company_ID:=$oCompanies[0].Company_ID
			oConnection.data.Order.Company_Name:=$oCompanies[0].Company_Name
			
			// HIDE THE LIST
			
			Ltg_JS_Send("autocompleteHide('orderCompany')")
			
			// BUILD DROPDOWN OF AVAILABLE COMPANY CONTACTS...
			
			xOrder_Contacts(oConnection.data.Order.Company_ID)
			
			// MATCHED SELECTION?
			
		: ($oCompanies.length>0)
			
			// BUILD THE LIST...
			
			$txtHTML:=""
			
			For each ($oCompany; $oCompanies)
				
				$txtHTML:=$txtHTML+"<li class=list-group-item><a class=text-secondary href=#>"+$oCompany.Company_Name+"</a></li>"
				
			End for each 
			
			// UPDATE THE LIST
			
			Ltg_JS_Send("ltgObj('orderCompany').html('"+$txtHTML+"')")
			
			// SHOW THE LIST
			
			Ltg_JS_Send("autocompleteShow('orderCompany')")
			
		Else 
			
			// HIDE THE LIST
			
			Ltg_JS_Send("autocompleteHide('orderCompany')")
	End case 
	
Else 
	
	// HIDE THE LIST
	
	Ltg_JS_Send("autocompleteHide('orderCompany')")
End if 
