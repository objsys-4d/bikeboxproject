//%attributes = {"shared":true}

// Project Method: BBOrder_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Order]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oOrd)  // Order RECORD
C_OBJECT:C1216($oOrder)  // Order SELECTION

C_TEXT:C284($txtOrder_ID)  // Order UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="orderDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW Order RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="order"))
	
	// LOAD THE Order SELECTION FOR PAGINATION CONTROL
	
	$oOrder:=BBOrder_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('order-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oOrd:=ds:C1482.Order.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Order:18]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// Order_UUID PASSED AS URL PARAMETER?
		
		$txtOrder_ID:=Ltg_URL_GetParam("order")
		
		If ($txtOrder_ID="")
			
			$txtOrder_ID:=oConnection.record
		End if 
		
		// LOAD THE Order
		
		$oOrd:=ds:C1482.Order.get($txtOrder_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.orderDetail.pageNumber:=$oOrd.indexOf($oOrder)+1
			oUser.orderDetail.pageCount:=$oOrder.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oOrd:=$oOrder[oUser.orderDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Order:=$oOrd  // Order

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.orderPageCount:=String:C10(oUser.orderDetail.pageCount)
oConnection.data.orderPageNumber:=String:C10(oUser.orderDetail.pageNumber)