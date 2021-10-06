//%attributes = {"shared":true}

// Project Method: Merch_Detail
// ---------------------------------------------------
// Version: 5.0
// ---------------------------------------------------
// Description: Edit a record for [Merchandise]
// ---------------------------------------------------

C_BOOLEAN:C305($flPaginate)  // PAGINATE FLAG

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

C_OBJECT:C1216($oMerch)  // Merchandise RECORD
C_OBJECT:C1216($oMerchandise)  // Merchandise SELECTION

C_TEXT:C284($txtMerchandise_ID)  // Merchandise UUID PARAMETER

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="merchDetail"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:=""
$oSettings.sortField:=""
$oSettings.sortOrder:=""

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// NOT A NEW Merchandise RECORD OR A DRILL-DOWN FROM A REFERER?

If ((oConnection.action#"new") & (oConnection.referer="merch"))
	
	// LOAD THE Merchandise SELECTION FOR PAGINATION CONTROL
	
	$oMerchandise:=Merch_List
	
	$flPaginate:=True:C214
Else 
	// HIDE PAGINATION FOR NEW RECORDS OR A DRILL-DOWN
	
	Ltg_JS_Send("ltgObj('merch-pagination').css('display','none')")
	
	$flPaginate:=False:C215
End if 

Case of 
		
		// *** NEW
		
	: (oConnection.action="new")
		
		$oMerch:=ds:C1482.Merchandise.new()
		
		// UPDATE LIGHTNING WITH THE UUID OF THE NEW RECORD
		
		oConnection.record:=[Merchandise:17]UUID:1
		
		// *** EDIT
		
	: (oConnection.action="edit")
		
		// Merchandise_UUID PASSED AS URL PARAMETER?
		
		$txtMerchandise_ID:=Ltg_URL_GetParam("merch")
		
		If ($txtMerchandise_ID="")
			
			$txtMerchandise_ID:=oConnection.record
		End if 
		
		// LOAD THE Merchandise
		
		$oMerch:=ds:C1482.Merchandise.get($txtMerchandise_ID)
		
		// UPDATE PAGINATION?
		
		If ($flPaginate)
			
			oUser.merchDetail.pageNumber:=$oMerch.indexOf($oMerchandise)+1
			oUser.merchDetail.pageCount:=$oMerchandise.length
		End if 
		
		// *** PAGINATION...
		
	: ((oConnection.action="first") | (oConnection.action="previous") | (oConnection.action="next") | (oConnection.action="last"))
		
		$oMerch:=$oMerchandise[oUser.merchDetail.pageNumber-1]
		
End case 

// UPDATE CONNECTION DATA...

oConnection.data.Merchandise:=$oMerch  // Merchandise

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE

oConnection.data.merchPageCount:=String:C10(oUser.merchDetail.pageCount)
oConnection.data.merchPageNumber:=String:C10(oUser.merchDetail.pageNumber)