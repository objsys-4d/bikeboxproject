//%attributes = {}
// ----------------------------------------------------
// User name (OS): edu.reyes
// Programmer: EDRJr.
// Date and time: 01/22/07, 13:25:57
// ----------------------------------------------------
// Method: GEN_Dlg_CenterWindow
// Description
// this is a generic method to display a centered form window and returns the status of the OK system variable (1 for OK or 0 for Cancel)
// the window is ALWAYS centered.
// 
// Parameters
// $1 - is the table pointer to where the form is located
// $2 - is the form name
// $3 - is the form title (Optional)
// $4 - is the window type (Optional)
// ----------------------------------------------------
C_LONGINT:C283($0; $WinRef; $width; $height; $WindowType)
C_POINTER:C301($1; $TablePtr)
C_TEXT:C284($2; $FormName; $FormTitle)
$TablePtr:=$1
$FormName:=$2
If (Count parameters:C259>=3)
	C_TEXT:C284($3)
	$FormTitle:=$3
End if 

If (Count parameters:C259=4)
	C_LONGINT:C283($4)
	$WindowType:=$4
Else 
	$WindowType:=Movable dialog box:K34:7
End if 

If ($TablePtr=Null:C1517)
	FORM GET PROPERTIES:C674($FormName; $width; $height)
	//$WinRef:=SYS_OpenCenteredWindow ($width;$height;$WindowType;$FormTitle)
	$WinRef:=Open form window:C675($FormName; $WindowType; Horizontally centered:K39:1; Horizontally centered:K39:1)
	SET WINDOW TITLE:C213($FormTitle; $WinRef)
	DIALOG:C40($FormName)
Else 
	FORM GET PROPERTIES:C674($TablePtr->; $FormName; $width; $height)
	$WinRef:=uCenterWindow($width; $height; $WindowType; $FormTitle)
	DIALOG:C40($TablePtr->; $FormName)
End if 
CLOSE WINDOW:C154
$0:=OK