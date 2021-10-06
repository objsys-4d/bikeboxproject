//%attributes = {"shared":true}
C_OBJECT:C1216($oCompany)

  // ROUTING...

$oCompany:=ds:C1482.Companies.get("752D81778E41493C92BC1888260CA694")  // ASSOCIATION OF ART MUSEUMS

If ($oCompany#Null:C1517)
	
	oConnection.data.companyName:=$oCompany.Company_Name
Else 
	oConnection.data.companyName:=""
End if 

  // EVENTS...

oConnection.data.demosInput:=""
oConnection.data.demosResult:=""

  // FOCUS...

oConnection.data.demosFocus1:=""
oConnection.data.demosFocus2:=""
oConnection.data.demosFocus3:=""

  // ACCORDION...

oConnection.data.demosPanel1:="Click Panel 1"
oConnection.data.demosPanel2:="Click Panel 2"
oConnection.data.demosPanel3:="Click Panel 3"

  // CHECKBOX/RADIOS...

oConnection.data.demosBoolean:="True"

oConnection.data.demosRadios:="Radio 2"

  // DATEPICKER...

oConnection.data.demosDate:=String:C10(Current date:C33(*))

oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE