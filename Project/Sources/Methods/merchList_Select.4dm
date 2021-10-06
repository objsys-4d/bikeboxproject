//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/21/21, 00:55:43
// ----------------------------------------------------
// Method: merchList_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (vblListSelect)
	vblListSelect:=False:C215
	vSelID:=Form:C1466.merchListlb.curItem.merchID
	vSelName:=Form:C1466.merchListlb.curItem.merchName
	vSelVariant:=Form:C1466.merchListlb.curItem.variant
	vSelStock:=Form:C1466.merchListlb.curItem.stock
	vSelPrice:=Form:C1466.merchListlb.curItem.price
	ACCEPT:C269
End if 