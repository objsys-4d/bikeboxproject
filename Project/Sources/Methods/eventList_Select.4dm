//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/21/21, 00:32:30
// ----------------------------------------------------
// Method: eventList_Select
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (vblListSelect)
	vblListSelect:=False:C215
	vSelID:=Form:C1466.eventListlb.curItem.eventID
	vSelName:=Form:C1466.eventListlb.curItem.eventName
	vSelDate:=Form:C1466.eventListlb.curItem.dateEvent
	ACCEPT:C269
End if 