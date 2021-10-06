//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/09/21, 21:14:33
// ----------------------------------------------------
// Method: Output_lbInit
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $lb_Name)
C_OBJECT:C1216($obj)

$lb_Name:=$1

$obj:=New object:C1471("Name"; $lb_Name)
$obj.data:=Null:C1517
$obj.data:=Form:C1466.data_list
$obj.currentItem:=Null:C1517
$obj.position:=Null:C1517
$obj.selected:=Null:C1517
$obj.meta:=New object:C1471

Form:C1466[$lb_Name]:=$obj

