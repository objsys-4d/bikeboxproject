//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 08/16/21, 20:17:38
// ----------------------------------------------------
// Method: UTIL_DropSpaces
// Description
// reduce the number of spaces in between words/names to 1
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $String)
C_LONGINT:C283($i)
$i:=0
$String:=$1
If (Length:C16($String)#0)  //not an empty string
	//-----------delete spaces before the word(s)
	While (Substring:C12($String; 1; 1)=" ")
		$String:=Delete string:C232($String; 1; 1)
	End while 
End if 
If (Length:C16($String)#0)  //not an empty string
	//-----------delete spaces after the word(s)
	While (Substring:C12($String; Length:C16($String); 1)=" ")
		$String:=Delete string:C232($String; Length:C16($String); 1)
	End while 
End if 
If (Length:C16($String)#0)  //not an empty string  
	$Len:=Length:C16($String)
	$i:=1
	//-----------delete spaces between words
	Repeat 
		$char:=Substring:C12($String; $i; 1)
		While (Substring:C12($String; $i; 1)=" ")
			If (Substring:C12($String; $i+1; 1)#" ")
				$i:=$i+1
			Else 
				$String:=Delete string:C232($String; $i; 1)
			End if 
		End while 
		$i:=$i+1
	Until ($i>=$Len)
	//-----------end
End if 
$0:=$String
