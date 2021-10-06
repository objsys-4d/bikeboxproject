//%attributes = {"shared":true}
C_TEXT:C284($1)

C_TEXT:C284($txtTab_ID)

$txtTab_ID:=$1

  // ACTIVATE THE TAB (REQUIRED IF A BUTTON CLICK)

Ltg_JS_Send ("ltgTabSetActive('"+$txtTab_ID+"')")

  // UPDATE CURRENT TAB ICON

Ltg_JS_Send ("ltgTabSetIcon('"+$txtTab_ID+"','fa fa-thumbs-up')")

  // UPDATE CURRENT TAB TITLE...

Case of 
		
	: ($txtTab_ID="tabs-tab-1")
		
		Ltg_JS_Send ("ltgTabSetTitle('tabs-tab-1','Tab 1 (Activated)')")
		
	: ($txtTab_ID="tabs-tab-2")
		
		Ltg_JS_Send ("ltgTabSetTitle('tabs-tab-2','Tab 2 (Activated)')")
		
	: ($txtTab_ID="tabs-tab-3")
		
		Ltg_JS_Send ("ltgTabSetTitle('tabs-tab-3','Tab 3 (Activated)')")
End case 
