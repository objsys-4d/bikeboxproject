//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oMerch)  // COMPANY RECORD
C_OBJECT:C1216($oMerchandise)  // COMPANY SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="merchList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="merchName"
$oSettings.sortField:="merchName"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.merchList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','merchName','"+Ltg_Str_Localise("%merchName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','variant','"+Ltg_Str_Localise("%variant")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','price','"+Ltg_Str_Localise("%price")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.merchList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('companyPageSize','pageSize-"+String:C10(oUser.merchList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.merchList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.merchList.searchFilter="merchName")
			
			$oMerchandise:=ds:C1482.Merchandise.query("merchName = :1"; "@"+oUser.merchList.searchString+"@")
			
		: (oUser.merchList.searchFilter="variant")
			
			$oMerchandise:=ds:C1482.Merchandise.query("variant = :1"; "@"+oUser.merchList.searchString+"@")
			
		: (oUser.merchList.searchFilter="price")
			
			$oMerchandise:=ds:C1482.Merchandise.query("price = :1"; Num:C11(oUser.merchList.searchString))
			
	End case 
Else 
	
	$oMerchandise:=ds:C1482.Merchandise.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.merchList.pageCount:=Abs:C99(Int:C8(-($oMerchandise.length/(oUser.merchList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oMerch; $oMerchandise)
	
	// ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472(""; $oMerch.UUID; $oMerch.merchName; $oMerch.variant; $oMerch.stock; String:C10($oMerch.price; "$###,##0.00")))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.merchTotal:=String:C10($oMerchandise.length; "###,###,###")

oConnection.data.merchDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.merchPageNumber:=String:C10(oUser.merchList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oMerchandise

