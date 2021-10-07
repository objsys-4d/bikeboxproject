 <!--
    Ltg_JS_Send ( script [text] )
        
    Sends a JavaScript script to the client.
 -->
 
# Ltg_JS_Send

*Ltg_JS_Send* ( _script_ [text] )

## Description

Sends a JavaScript _script_ to the client.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*script*      | JavaScript                            | [text]

## Example

```4d
    // UPDATE PANEL HEADER ICON
	
    Ltg_JS_Send ("ltgAccordionPanelSetIcon('accordion-header-1','fa fa-thumbs-up')")
		
    // UPDATE PANEL HEADER TITLE
	
    Ltg_JS_Send ("ltgAccordionPanelSetTitle('accordion-header-1','Panel 1 (activated)')")
		
    // UPDATE PANEL CONTENT CLASS
	
    Ltg_JS_Send ("ltgObj('.demosPanel1').removeClass('is-invalid')")
    Ltg_JS_Send ("ltgObj('.demosPanel1').addClass('is-valid')")
```

## See also

**Ltg_Conn_Update**

**README_JAVASCRIPT**