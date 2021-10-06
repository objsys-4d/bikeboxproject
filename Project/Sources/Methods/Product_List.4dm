//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oProduct)  // PRODUCT RECORD
C_OBJECT:C1216($oProducts)  // PRODUCTS SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

  // SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="productsList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="product"
$oSettings.sortField:="Product"
$oSettings.sortOrder:="asc"

  // INITIALISE FORM SETTINGS

Form_Settings ($oSettings)

  // UPDATE SEARCH...

Ltg_JS_Send ("ltgObj('.searchString').val('"+oUser.productsList.searchString+"')")

Ltg_JS_Send ("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','product','"+Ltg_Str_Localise ("%product")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','type','"+Ltg_Str_Localise ("%type")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','colour','"+Ltg_Str_Localise ("%colour")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','size','"+Ltg_Str_Localise ("%size")+"')")

Ltg_JS_Send ("ltgSelectSetValue('.searchFilter','"+oUser.productsList.searchFilter+"')")

  // ACTIVE SEARCH?

If (oUser.productsList.searchString#"")
	
	  // FILTER SEARCH...
	
	Case of 
		: (oUser.productsList.searchFilter="product")
			
			$oProducts:=ds:C1482.Products.query("Product = :1";"@"+oUser.productsList.searchString+"@")
			
		: (oUser.productsList.searchFilter="type")
			
			$oProducts:=ds:C1482.Products.query("Type = :1";"@"+oUser.productsList.searchString+"@")
			
		: (oUser.productsList.searchFilter="colour")
			
			$oProducts:=ds:C1482.Products.query("Colour = :1";"@"+oUser.productsList.searchString+"@")
			
		: (oUser.productsList.searchFilter="size")
			
			$oProducts:=ds:C1482.Products.query("Size = :1";"@"+oUser.productsList.searchString+"@")
	End case 
Else 
	
	$oProducts:=ds:C1482.Products.all()
End if 

  // UPDATE PAGINATION PAGE COUNT

oUser.productsList.pageCount:=Abs:C99(Int:C8(-($oProducts.length/(oUser.productsList.pageSize))))

  // *** DATATABLES ***

  // FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oProduct;$oProducts)
	
	  // ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472($oProduct.Product;$oProduct.Colour;$oProduct.Icon;Ltg_Str_Localise ("%"+$oProduct.Type);Ltg_Str_Localise ("%"+$oProduct.Colour);Ltg_Str_Localise ("%"+$oProduct.Size);String:C10($oProduct.Rate;oConnection.session.userCurrency)))
	
End for each 

  // UPDATE CONNECTION DATA...

oConnection.data.productsTotal:=String:C10($oProducts.length)

oConnection.data.productsDataTable:=JSON Stringify:C1217($oDataTable)
