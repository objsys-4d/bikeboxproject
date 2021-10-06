//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/20/21, 22:19:44
// ----------------------------------------------------
// Method: objDeleteListboxElement
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $lbObjName)
C_OBJECT:C1216($objSuccess)
$lbObjName:=$1

$selectionLength:=Form:C1466[$lbObjName].curSel.length

If ($selectionLength=0) | ($selectionLength=1)  //0 = must be edit mode
	$objSuccess:=Form:C1466[$lbObjName].curItem.drop()
Else 
	$objSuccess:=Form:C1466[$lbObjName].curSel.drop()
End if 

