//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/20/21, 19:23:49
// ----------------------------------------------------
// Method: companyList_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (vblListSelect)
	vblListSelect:=False:C215
	vSelID:=Form:C1466.companyListlb.curItem.companyID
	vSelName:=Form:C1466.companyListlb.curItem.companyName
	vSelPhone:=Form:C1466.companyListlb.curItem.phone1
	vSelEmail:=Form:C1466.companyListlb.curItem.email
	ACCEPT:C269
End if 
