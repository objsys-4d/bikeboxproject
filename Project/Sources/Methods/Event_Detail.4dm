//%attributes = {"shared":true}

// Project Method: Event_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Event]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oEvt)  // Event RECORD
C_OBJECT:C1216($oEvent)  // Event SELECTION

C_TEXT:C284($txtEvent_ID)  // Event UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="eventDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW Event RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="Event"))
	
	// LOAD THE Event SELECTION FOR PAGINATION CONTROL
	
	$oEvent:=Event_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('event-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oEvt:=ds:C1482.Event.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Event:21]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// Event UUID PASSED AS URL PARAMETER?
		
		$txtEvent_ID:=Ltg_URL_GetParam("event")
		
		If ($txtEvent_ID="")
			
			$txtEvent_ID:=oConnection.record
		End if 
		
		// LOAD THE Event
		
		$oEvt:=ds:C1482.Event.get($txtEvent_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.eventDetail.pageNumber:=$oEvt.indexOf($oEvent)+1
			oUser.eventDetail.pageCount:=$oEvent.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oEvt:=$oEvent[oUser.eventDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Event:=$oEvt  // Event

If ($oEvt.recurring)
	Ltg_JS_Send("ltgObj('Event.recurring').prop('checked', true)")
Else 
	Ltg_JS_Send("ltgObj('Event.recurring').prop('checked', false)")
End if 

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.eventPageCount:=String:C10(oUser.eventDetail.pageCount)
oConnection.data.eventPageNumber:=String:C10(oUser.eventDetail.pageNumber)