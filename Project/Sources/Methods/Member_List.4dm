//%attributes = {"shared":true}
C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oMem)  // Course RECORD
C_OBJECT:C1216($oMember)  // Course SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="memberList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="lastName"
$oSettings.sortField:="lastName"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.memberList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','lastName','"+Ltg_Str_Localise("%lastName")+"')")
Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.memberList.searchFilter+"')")

// ACTIVE SEARCH?

If (oUser.memberList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.memberList.searchFilter="lastName")
			
			$oMember:=ds:C1482.Member.query("lastName = :1"; "@"+oUser.memberList.searchString+"@")
			
			
	End case 
Else 
	
	$oMember:=ds:C1482.Member.all()
End if 

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472

For each ($oMem; $oMember)
	
	// ADD TO DATATABLES (JSON)
	
	$oDataTable.push(New collection:C1472(""; $oMem.UUID; $oMem.lastName; $oMem.firstName; $oMem.membershipType; $oMem.phone; $oMem.email))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.memberTotal:=String:C10($oMember.length; "###,###,###")

oConnection.data.memberDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.memberPageNumber:=String:C10(oUser.memberList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oMember
