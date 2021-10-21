//%attributes = {}
// ----------------------------------------------------
// User name (OS): edu.reyes
// Date and time: 01/17/07, 11:40:18
// ----------------------------------------------------
// Method: GEN_Listbox_DoubleClickEmpty(->ListBoxVarName)
// Description
// this method detects a double click on an empty row/column of a list box
// returns TRUE if the row/column is empty or FALSE, otherwise
// Parameters
// pass a pointer to the LISTBOX VARIABLE NAME
// ----------------------------------------------------
C_POINTER:C301($1; $listboxPtr)
C_BOOLEAN:C305($0)

$listboxPtr:=$1

If ($listboxPtr->=0)
	$0:=True:C214
Else 
	$0:=False:C215
End if 