//%attributes = {}
// ----------------------------------------------------
// User name (OS): edu.reyes
// Date and time: 09/21/06, 11:03:11
// ----------------------------------------------------
// Method: GEN_ListBox_DeleteSelection
// Description
// method removes the selected (highlighted) item in a list box
//
// Parameters
// pass a pointer to the list box
// ----------------------------------------------------
C_POINTER:C301($1; $ptrListBoxObj)
$ptrListBoxObj:=$1
C_LONGINT:C283($elem)
GOTO OBJECT:C206($ptrListBoxObj->)
For ($i; 1; Size of array:C274($ptrListBoxObj->))
	If ($ptrListBoxObj->{$i})
		$elem:=$i
		$i:=Size of array:C274($ptrListBoxObj->)+1
	End if 
End for 

LISTBOX DELETE ROWS:C914($ptrListBoxObj->; $elem)
If (Size of array:C274($ptrListBoxObj->)=0)
	$ptrListBoxObj->:=0
End if 
