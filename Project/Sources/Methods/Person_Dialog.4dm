//%attributes = {"shared":true}
C_OBJECT:C1216($0)

C_COLLECTION:C1488($oDataTable)  // DATATABLES.JS - JSON DATA

C_OBJECT:C1216($oPrn)  // PERSON RECORD
C_OBJECT:C1216($oPerson)  // PERSON SELECTION

C_OBJECT:C1216($oSettings)  // FORM SETTINGS

// SETUP DEFAULT FORM SETTINGS...

$oSettings:=New object:C1471

$oSettings.form:="personList"  // INTERNAL FORM NAME WITHOUT EXTENSION
$oSettings.searchFilter:="lastName"
$oSettings.sortField:="lastName"
$oSettings.sortOrder:="asc"

// INITIALISE FORM SETTINGS

Form_Settings($oSettings)

// UPDATE SEARCH...

Ltg_JS_Send("ltgObj('.searchString').val('"+oUser.personList.searchString+"')")

Ltg_JS_Send("ltgSelectDeleteOptions('.searchFilter')")

Ltg_JS_Send("ltgSelectAddOption('.searchFilter','lastName','"+Ltg_Str_Localise("%lastName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','firstName','"+Ltg_Str_Localise("%firstName")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','address','"+Ltg_Str_Localise("%address")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','country','"+Ltg_Str_Localise("%country")+"')")
Ltg_JS_Send("ltgSelectAddOption('.searchFilter','email','"+Ltg_Str_Localise("%email")+"')")

Ltg_JS_Send("ltgSelectSetValue('.searchFilter','"+oUser.personList.searchFilter+"')")

// UPDATE PAGINATION PAGE SIZE

Ltg_JS_Send("ltgSelectSetValue('companyPageSize','pageSize-"+String:C10(oUser.personList.pageSize)+"')")

// ACTIVE SEARCH?

If (oUser.personList.searchString#"")
	
	// FILTER SEARCH...
	
	Case of 
		: (oUser.personList.searchFilter="lastName")
			
			$oPerson:=ds:C1482.Person.query("lastName = :1"; "@"+oUser.personList.searchString+"@")
			
		: (oUser.personList.searchFilter="firstName")
			
			$oPerson:=ds:C1482.Person.query("firstName = :1"; "@"+oUser.personList.searchString+"@")
			
		: (oUser.personList.searchFilter="address")
			
			$oPerson:=ds:C1482.Person.query("address1 = :1 or city = :1 or state = :1"; "@"+oUser.personList.searchString+"@")
			
		: (oUser.personList.searchFilter="country")
			
			$oPerson:=ds:C1482.Person.query("country = :1"; oUser.personList.searchString+"@")
			
		: (oUser.personList.searchFilter="email")
			
			$oPerson:=ds:C1482.Person.query("email = :1"; oUser.personList.searchString+"@")
			
	End case 
Else 
	
	$oPerson:=ds:C1482.Person.all()
	
End if 

// UPDATE PAGINATION PAGE COUNT

oUser.personList.pageCount:=Abs:C99(Int:C8(-($oPerson.length/(oUser.personList.pageSize))))

// *** DATATABLES ***

// FOR THIS WE'RE USING A DIRECT JSON DATA VALUE RATHER THAN AN AJAX REQUEST, WHICH WOULD BE ANOTHER SERVER CONNECTION REQUEST.

$oDataTable:=New collection:C1472
C_TEXT:C284($addr)
For each ($oPrn; $oPerson)
	
	// ADD TO DATATABLES (JSON)
	$addr:=$oPrn.address1
	If ($oPrn.city#"")
		$addr:=$addr+", "+$oPrn.city
	End if 
	If ($oPrn.state#"")
		$addr:=$addr+", "+$oPrn.state
	End if 
	
	
	//$oDataTable.push(New collection(""; $oPrn.UUID; $oPrn.lastName; $oPrn.firstName; $addr; $oPrn.country; $oPrn.email))
	//$oDataTable.push(New collection(""; $oPrn.UUID; $oPrn.fullName; $addr; $oPrn.country; $oPrn.email))
	$oDataTable.push(New collection:C1472(""; $oPrn.UUID; $oPrn.fullName))  //; $addr; $oPrn.country; $oPrn.email))
	
End for each 

// UPDATE CONNECTION DATA...

oConnection.data.personTotal:=String:C10($oPerson.length; "###,###,###")

oConnection.data.personDataTable:=JSON Stringify:C1217($oDataTable)

oConnection.data.personPageNumber:=String:C10(oUser.personList.pageNumber-1)  // THE DATATABLES PAGE TO DISPLAY (STARTS FROM ZERO)

$0:=$oPerson

