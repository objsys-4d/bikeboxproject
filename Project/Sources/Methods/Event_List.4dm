//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oEvt)  // Event RECORD
C_OBJECT:C1216($oEvent)  // Event SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="eventList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="dateEvent"
$oSettings.sortField:="dateEvent"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.eventList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','dateEvent','"+Ltg_Str_Localise("%dateEvent")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','eventName','"+Ltg_Str_Localise("%eventName")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.eventList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('eventPageSize','pageSize-"+String:C10(oUser.eventList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.eventList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.eventList.searchFilter="dateEvent")
			
			$oEvent:=ds:C1482.Event.query("dateEvent = :1"; Date:C102(oUser.eventList.searchString))
			
		: (oUser.eventList.searchFilter="eventName")
			
			$oEvent:=ds:C1482.Event.query("eventName = :1"; "@"+oUser.eventList.searchString+"@")
			
	End case 
Else 
	
	$oEvent:=ds:C1482.Event.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.eventList.pageCount:=Abs:C99(Int:C8(-($oEvent.length/(oUser.eventList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oEvt; $oEvent)
	
	// ADD TO DATATABLES (JSON)
	
	//$oDataTable.push(New collection(""; $oEvt.UUID; String($oEvt.dateEvent); $oEvt.eventName; String($oEvt.totalDonation; $###, ###, ###, ##0##)))
	$oDataTable.push(New collection:C1472(""; $oEvt.UUID; $oEvt.dateEvent; $oEvt.eventName; String:C10($oEvt.totalDonation; "$###, ###, ###, ##0.00")))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.eventTotal:=String:C10($oEvent.length; "###,###,###")

oConnection.data.eventDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.eventPageNumber:=String:C10(oUser.eventList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oEvent

