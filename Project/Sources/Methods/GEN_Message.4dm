//%attributes = {}
// ----------------------------------------------------
// User name (OS): edu.reyes
// Programmer: EDRJr.
// Date and time: 07/10/06, 14:30:51
// ----------------------------------------------------
// Method: GEN_Message
// Description
// method opens a 400x100 message dialog box 
// Parameters
// accepts 4 parameters where 3 parameters are optional
// if 3rd & 4th paramter is not entered, both will have a default value if 1
// ----------------------------------------------------
C_BOOLEAN:C305(vblNoMessage)

If (vblNoMessage=False:C215)
	C_TEXT:C284($1; $windStat; $message)
	C_LONGINT:C283($x; $y)
	$windStat:=$1
	
	Case of 
		: (Count parameters:C259=1)
			$message:=""
			$x:=1
			$y:=1
		: (Count parameters:C259=2)
			C_TEXT:C284($2)
			$message:=$2
			$x:=1
			$y:=1
		: (Count parameters:C259>2)
			C_TEXT:C284($2)
			C_LONGINT:C283($3; $4)
			$message:=$2
			$x:=$3
			$y:=$4
		Else 
			$message:=""
			$x:=1
			$y:=1
	End case 
	
	Case of 
		: ($windStat="open")
			uCenterWindow(450; 150; Movable dialog box:K34:7; "Please Wait...")
			DELAY PROCESS:C323(Current process:C322; 0.1)  //give chance for text to load
			GOTO XY:C161($x; $y)
			MESSAGE:C88($message)
			
		: ($windStat="update")
			DELAY PROCESS:C323(Current process:C322; 0.00001)  //give chance for text to load
			GOTO XY:C161($x; $y)
			MESSAGE:C88($message)
			
		: ($windStat="erase")
			ERASE WINDOW:C160
			
		: ($windStat="close")
			CLOSE WINDOW:C154
	End case 
	
End if 