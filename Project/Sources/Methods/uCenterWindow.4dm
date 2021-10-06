//%attributes = {}
If (False:C215)
	// (P) uCenterWindow: Creates centered window
	// $1 = desired screen width
	// $2 = desired screen height
	// $3 = window type
	// $4 = screen title
	//Ex - uCenterWindow ($2;$1;$title;$3)
End if 
C_LONGINT:C283($0; $1; $2; $3; $lLeft; $lTop; $lRight; $lBottom; $Type)
C_LONGINT:C283($winRef)
//C_Text($4;$title)// Modified by: Mike Beatty (9/29/20) - MMV18-13, Replace _O_C_STRING (80;
C_TEXT:C284($4; $title)  // Modified by: Guy Algot (9/30/20) ` MMV18-13, Replace ARRAY STRING
If (Count parameters:C259<4)
	$title:=""
Else 
	$title:=$4
End if 

Case of 
	: (Is macOS:C1572)  //Running Mac version   
		//CenterWindow ($2;$1;$title;$3)
		//WS CENTER RECT ($1;$2;$lLeft;$lTop;$lRight;$lBottom)
		$sh:=Screen height:C188
		$sw:=Screen width:C187
		$sh:=$sh\2
		$sw:=$sw\2
		$lLeft:=$sw-($1/2)
		$lTop:=$sh-($2/2)
		$lRight:=$sw+($1/2)
		$lBottom:=$sh+($2/2)
		$winRef:=Open window:C153($lLeft; $lTop; $lRight; $lBottom; $3; $title)
	: (Is Windows:C1573)  //Running Windows version
		//WS CENTER RECT ($1;$2;$lLeft;$lTop;$lRight;$lBottom)
		$sh:=Screen height:C188
		$sw:=Screen width:C187
		$sh:=$sh\2
		$sw:=$sw\2
		$lLeft:=$sw-($1/2)
		$lTop:=$sh-($2/2)
		$lRight:=$sw+($1/2)
		$lBottom:=$sh+($2/2)
		If ($3=1)
			$Type:=1
		Else 
			$Type:=$3
		End if 
		$0:=Open window:C153($lLeft; $lTop; $lRight; $lBottom; $Type; $title)
	Else 
		ALERT:C41("No external available."+Char:C90(13)+"Contact Administrator and mention 'uCenterWindow'")
End case 
//EOP