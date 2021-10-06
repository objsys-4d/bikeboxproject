//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/24/21, 21:14:50
// ----------------------------------------------------
// Method: PersonCompany_Cancel
// Description
// 
//
// Parameters
// ----------------------------------------------------

oConnection.data.Person.company:="0"
oConnection.data.Person.companyID:=0

oConnection.form:="person-detail.html"
oConnection.action:="index"

oConnection.responseType:="javascript"
