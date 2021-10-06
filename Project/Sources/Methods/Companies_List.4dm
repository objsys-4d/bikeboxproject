//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oCompany)  // COMPANY RECORD
C_OBJECT:C1216($oCompanies)  // COMPANIES SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

  // SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="companiesList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="name"
$oSettings.sortField:="Company_Name"
$oSettings.sortOrder:="asc"

  // INITIALISE FORM SETTINGS

Form_Settings ($oSettings)

  // UPDATE SEARCH...

Ltg_JS_Send ("ltgObj('.searchString').val('"+oUser.companiesList.searchString+"')")

Ltg_JS_Send ("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','name','"+Ltg_Str_Localise ("%company_name")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','address','"+Ltg_Str_Localise ("%address")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','city','"+Ltg_Str_Localise ("%city")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','postcode','"+Ltg_Str_Localise ("%postcode")+"')")

Ltg_JS_Send ("ltgSelectSetValue('.searchFilter','"+oUser.companiesList.searchFilter+"')")

  // UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send ("ltgSelectSetValue('companiesPageSize','pageSize-"+String:C10(oUser.companiesList.pageSize)+"')")

  // ACTIVE SEARCH?

If (oUser.companiesList.searchString#"")
	
	  // FILTER SEARCH...
	
	Case of 
		: (oUser.companiesList.searchFilter="name")
			
			$oCompanies:=ds:C1482.Companies.query("Company_Name = :1";oUser.companiesList.searchString+"@")
			
		: (oUser.companiesList.searchFilter="address")
			
			$oCompanies:=ds:C1482.Companies.query("Address = :1";"@"+oUser.companiesList.searchString+"@")
			
		: (oUser.companiesList.searchFilter="city")
			
			$oCompanies:=ds:C1482.Companies.query("City = :1";oUser.companiesList.searchString+"@")
		: (oUser.companiesList.searchFilter="postcode")
			
			$oCompanies:=ds:C1482.Companies.query("Postcode = :1";oUser.companiesList.searchString+"@")
	End case 
Else 
	
	$oCompanies:=ds:C1482.Companies.all()
	
End if 

  // UPDATE PAGINATION PAGE COUNT

oUser.companiesList.pageCount:=Abs:C99(Int:C8(-($oCompanies.length/(oUser.companiesList.pageSize))))

  // *** DATATABLES ***

  // FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oCompany;$oCompanies)
	
	  // ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472("";$oCompany.Company_ID;$oCompany.Company_Name;$oCompany.Address;$oCompany.City;$oCompany.Postcode))
	
End for each 

  // UPDATE CONNECTION DATA...

oConnection.data.companiesTotal:=String:C10($oCompanies.length;"###,###,###")

oConnection.data.companiesDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.companiesPageNumber:=String:C10(oUser.companiesList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oCompanies

