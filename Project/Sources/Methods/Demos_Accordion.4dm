//%attributes = {"shared":true}
C_TEXT:C284($1)  // PANEL ID

C_TEXT:C284($txtPanel_ID)

$txtPanel_ID:=$1

  // ACTIVATE THE PANEL

Ltg_JS_Send ("ltgAccordionPanelSetActive('"+$txtPanel_ID+"')")

Case of 
		
	: ($txtPanel_ID="accordion-panel-1")
		
		  // UPDATE DATA
		oConnection.data.demosPanel1:="Panel 1 activated at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
		
		  // UPDATE PANEL HEADER ICON
		Ltg_JS_Send ("ltgAccordionPanelSetIcon('accordion-header-1','fa fa-thumbs-up')")
		
		  // UPDATE PANEL HEADER TITLE
		Ltg_JS_Send ("ltgAccordionPanelSetTitle('accordion-header-1','Panel 1 (activated)')")
		
		  // UPDATE PANEL CONTENT CLASS
		Ltg_JS_Send ("ltgObj('.demosPanel1').removeClass('is-invalid')")
		Ltg_JS_Send ("ltgObj('.demosPanel1').addClass('is-valid')")
		
	: ($txtPanel_ID="accordion-panel-2")
		
		  // UPDATE DATA
		oConnection.data.demosPanel2:="Panel 2 activated at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
		
		  // UPDATE PANEL HEADER ICON
		Ltg_JS_Send ("ltgAccordionPanelSetIcon('accordion-header-2','fa fa-thumbs-up')")
		
		  // UPDATE PANEL HEADER TITLE
		Ltg_JS_Send ("ltgAccordionPanelSetTitle('accordion-header-2','Panel 2 (activated)')")
		
		  // UPDATE PANEL CONTENT CLASS
		Ltg_JS_Send ("ltgObj('.demosPanel2').removeClass('is-invalid')")
		Ltg_JS_Send ("ltgObj('.demosPanel2').addClass('is-valid')")
		
	: ($txtPanel_ID="accordion-panel-3")
		
		  // UPDATE DATA
		oConnection.data.demosPanel3:="Panel 3 activated at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
		
		  // UPDATE PANEL HEADER ICON
		Ltg_JS_Send ("ltgAccordionPanelSetIcon('accordion-header-3','fa fa-thumbs-up')")
		
		  // UPDATE PANEL HEADER TITLE
		Ltg_JS_Send ("ltgAccordionPanelSetTitle('accordion-header-3','Panel 3 (activated)')")
		
		  // UPDATE PANEL CONTENT CLASS
		Ltg_JS_Send ("ltgObj('.demosPanel3').removeClass('is-invalid')")
		Ltg_JS_Send ("ltgObj('.demosPanel3').addClass('is-valid')")
End case 
