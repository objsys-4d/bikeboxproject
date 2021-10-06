//%attributes = {"shared":true}
C_OBJECT:C1216($oSettings)  // FORM SETTINGS

  // SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="ordersList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="number"
$oSettings.sortField:="Order_ID"
$oSettings.sortOrder:="asc"

  // INITIALISE FORM SETTINGS

Form_Settings ($oSettings)

  // UPDATE SEARCH...

Ltg_JS_Send ("ltgObj('.searchString').val('"+oUser.ordersList.searchString+"')")

Ltg_JS_Send ("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','number','"+Ltg_Str_Localise ("%number")+"')")
Ltg_JS_Send ("ltgSelectAddOption('.searchFilter','company','"+Ltg_Str_Localise ("%company_name")+"')")

Ltg_JS_Send ("ltgSelectSetValue('.searchFilter','"+oUser.ordersList.searchFilter+"')")

  // NOTE: THE ORDERS DATA IS HANDLED BY THE METHOD "ORDERS_DATATABLE"
