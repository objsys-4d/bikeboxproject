//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/21/21, 21:16:14
// ----------------------------------------------------
// Method: personList_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (vblListSelect)
	vblListSelect:=False:C215
	vSelID:=Form:C1466.personListlb.curItem.personID
	vSelCoID:=Form:C1466.personListlb.curItem.companyID
	vSelName:=Form:C1466.personListlb.curItem.lastName+", "+Form:C1466.personListlb.curItem.firstName
	vSelPhone:=Form:C1466.personListlb.curItem.phone
	vSelEmail:=Form:C1466.personListlb.curItem.email
	vSelAddr1:=Form:C1466.personListlb.curItem.address1
	vSelCity:=Form:C1466.personListlb.curItem.city
	vSelState:=Form:C1466.personListlb.curItem.state
	vSelZip:=Form:C1466.personListlb.curItem.postalCode
	ACCEPT:C269
End if 
