//%attributes = {"shared":true}
C_TEXT:C284($1)  // ITEM_ID

C_OBJECT:C1216($oItem)

$oItem:=ds:C1482.OrderItem.get($1)

If ($oItem#Null:C1517)
	
	$oItem.drop()
	
	BBOrder_Save
	
End if 
