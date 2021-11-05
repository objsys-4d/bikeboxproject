//%attributes = {"shared":true}
C_TEXT:C284($1)  // ITEM_ID

C_OBJECT:C1216($oItem)

$oItem:=ds:C1482.Order_Items.get($1)

If ($oItem#Null:C1517)
	
	$oItem.drop()
	
	Order_Save
	
End if 
