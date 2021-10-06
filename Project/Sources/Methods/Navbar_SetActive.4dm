//%attributes = {}
C_TEXT:C284($1)

C_TEXT:C284($txtNav_Item)  // CURRENT NAV ITEM

$txtNav_Item:=$1

  // DISPLAY SEARCH

Ltg_JS_Send ("ltgObj('navbar-search').removeClass('d-none')")

  // CLOSE ALL OPEN NAV ITEMS

Ltg_JS_Send ("ltgAccordionPanelClose('nav-companies-panel')")
Ltg_JS_Send ("ltgAccordionPanelClose('nav-contacts-panel')")
Ltg_JS_Send ("ltgAccordionPanelClose('nav-products-panel')")
Ltg_JS_Send ("ltgAccordionPanelClose('nav-orders-panel')")
Ltg_JS_Send ("ltgAccordionPanelClose('nav-demos-panel')")

  // ADD ACTIVE NAV ITEM?

If ($txtNav_Item#"")
	
	  // REMOVE ANY ACTIVE NAV ITEM CLASS...
	
	Ltg_JS_Send ("ltgObj('nav-dashboard').removeClass('active')")
	Ltg_JS_Send ("ltgObj('nav-companies').removeClass('active')")
	Ltg_JS_Send ("ltgObj('nav-contacts').removeClass('active')")
	Ltg_JS_Send ("ltgObj('nav-products').removeClass('active')")
	Ltg_JS_Send ("ltgObj('nav-orders').removeClass('active')")
	Ltg_JS_Send ("ltgObj('nav-demos').removeClass('active')")
	
	  // SET THE ACTIVE NAV ITEM CLASS
	
	Ltg_JS_Send ("ltgObj('"+$txtNav_Item+"').addClass('active')")
	
	  // SET THE SEARCH VISIBILITY...
	
	Case of 
			
			  // DASHBOARD (HIDE SEARCH)
			
		: ($txtNav_Item="nav-dashboard")
			
			Ltg_JS_Send ("ltgObj('navbar-search').addClass('d-none')")
			
			  // DEMOS (HIDE SEARCH)
			
		: ($txtNav_Item="nav-demos")
			
			Ltg_JS_Send ("ltgObj('navbar-search').addClass('d-none')")
	End case 
End if 
