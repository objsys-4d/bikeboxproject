//%attributes = {}
// ----------------------------------------------------
// User name (OS): edu.reyes
// Programmer: EDRJr.
// Date and time: 06/02/06, 17:52:17
// ----------------------------------------------------
// Method: GEN_ListBox_AllItemsSelect
// Description
// method selects or disselects all items in the listbox
//
// Parameters
// pass a pointer to the listbox variable name and true for select all, false for disselect all
// $1 - Pointer to the listbox (variable name)
// $2 - TRUE for Select All, FALSE for no selection
// ----------------------------------------------------

C_POINTER:C301($1; $ptrListBoxObj)
C_BOOLEAN:C305($2; $select)

$ptrListBoxObj:=$1
$select:=$2
C_LONGINT:C283($elem)

If (Size of array:C274($ptrListBoxObj->)#0)
	For ($i; 1; Size of array:C274($ptrListBoxObj->))
		$ptrListBoxObj->{$i}:=$select
	End for 
End if 