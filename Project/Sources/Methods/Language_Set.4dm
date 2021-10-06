//%attributes = {"shared":true}
C_TEXT:C284($1)  // LANGUAGE CODE

oConnection.session.userLanguage:=$1

// SET CURRENCY...

Case of 
	: (oConnection.session.userLanguage="en-US")
		
		oConnection.session.userCurrency:="$###,###,##0.00"
		
	: (oConnection.session.userLanguage="en-GB")
		
		oConnection.session.userCurrency:="£###,###,##0.00"
		
	: (oConnection.session.userLanguage="fr")
		
		oConnection.session.userCurrency:="€###,###,##0.00"
End case 

// UPDATE THE LANGUAGE FOR INDEX.HTML...

Ltg_JS_Send("ltgObj('.searchString').attr('placeholder','"+Ltg_Str_Localise("%search")+"...')")

Ltg_JS_Send("ltgObj('notifications_title').html('"+Ltg_Str_Localise("%notifications")+"')")
Ltg_JS_Send("ltgObj('notifications_clear').html('"+Ltg_Str_Localise("%notifications_clear")+"')")

Ltg_JS_Send("ltgObj('dashboard_menu').html('"+Ltg_Str_Localise("%dashboard")+"')")

Ltg_JS_Send("ltgObj('companies_menu').html('"+Ltg_Str_Localise("%companies")+"')")
Ltg_JS_Send("ltgObj('companies_menu_list').html('"+Ltg_Str_Localise("%company")+" "+Ltg_Str_Localise("%list")+"')")
Ltg_JS_Send("ltgObj('companies_menu_new').html('"+Ltg_Str_Localise("%new")+" "+Ltg_Str_Localise("%company")+"')")
Ltg_JS_Send("ltgObj('companies_menu_export').html('"+Ltg_Str_Localise("%export")+" "+Ltg_Str_Localise("%companies")+"')")

Ltg_JS_Send("ltgObj('contacts_menu').html('"+Ltg_Str_Localise("%contacts")+"')")
Ltg_JS_Send("ltgObj('contacts_menu_list').html('"+Ltg_Str_Localise("%contact")+" "+Ltg_Str_Localise("%list")+"')")

Ltg_JS_Send("ltgObj('products_menu').html('"+Ltg_Str_Localise("%products")+"')")
Ltg_JS_Send("ltgObj('products_menu_list').html('"+Ltg_Str_Localise("%product")+" "+Ltg_Str_Localise("%list")+"')")

Ltg_JS_Send("ltgObj('orders_menu').html('"+Ltg_Str_Localise("%orders")+"')")
Ltg_JS_Send("ltgObj('orders_menu_list').html('"+Ltg_Str_Localise("%order")+" "+Ltg_Str_Localise("%list")+"')")
Ltg_JS_Send("ltgObj('orders_menu_new').html('"+Ltg_Str_Localise("%new")+" "+Ltg_Str_Localise("%order")+"')")

Ltg_JS_Send("ltgObj('demos_menu').html('"+Ltg_Str_Localise("%demos")+"')")
Ltg_JS_Send("ltgObj('demos_menu_demos').html('"+Ltg_Str_Localise("%demos")+"')")