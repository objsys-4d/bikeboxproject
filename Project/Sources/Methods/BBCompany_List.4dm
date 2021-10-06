//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oCmp)  // COMPANY RECORD
C_OBJECT:C1216($oCompany)  // COMPANY SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="companyList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="companyName"
$oSettings.sortField:="companyName"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.companyList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','companyName','"+Ltg_Str_Localise("%companyName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','address','"+Ltg_Str_Localise("%address")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','city','"+Ltg_Str_Localise("%city")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','state','"+Ltg_Str_Localise("%state")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','email','"+Ltg_Str_Localise("%email")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.companyList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('companyPageSize','pageSize-"+String:C10(oUser.companyList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.companyList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.companyList.searchFilter="companyName")
			
			$oCompany:=ds:C1482.Company.query("companyName = :1"; "@"+oUser.companyList.searchString+"@")
			
		: (oUser.companyList.searchFilter="address")
			
			$oCompany:=ds:C1482.Company.query("address = :1"; oUser.companyList.searchString+"@")
			
		: (oUser.companyList.searchFilter="city")
			
			$oCompany:=ds:C1482.Company.query("city = :1"; oUser.companyList.searchString+"@")
			
		: (oUser.companyList.searchFilter="state")
			
			$oCompany:=ds:C1482.Company.query("state = :1"; oUser.companyList.searchString+"@")
			
		: (oUser.companyList.searchFilter="email")
			
			$oCompany:=ds:C1482.Company.query("email = :1"; oUser.companyList.searchString+"@")
			
	End case 
Else 
	
	$oCompany:=ds:C1482.Company.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.companyList.pageCount:=Abs:C99(Int:C8(-($oCompany.length/(oUser.companyList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oCmp; $oCompany)
	
	// ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472(""; $oCmp.UUID; $oCmp.companyName; $oCmp.address; $oCmp.city; $oCmp.state; $oCmp.email))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.companyTotal:=String:C10($oCompany.length; "###,###,###")

oConnection.data.companyDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.companyPageNumber:=String:C10(oUser.companyList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oCompany

