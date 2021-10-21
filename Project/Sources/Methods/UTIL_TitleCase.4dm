//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 08/16/21, 20:19:26
// ----------------------------------------------------
// Method: UTIL_TitleCase
// Description
// Capitalize the first letter after space, punctuation marks, 
// and other special characters
// (the term is called Title Case or Capital Case)
//
// Parameters
// ----------------------------------------------------
$0:=Lowercase:C14($1)
$vlLen:=Length:C16($0)

If ($vlLen>0)
	$0[[1]]:=Uppercase:C13($0[[1]])
	For ($vlChar; 1; $vlLen-1)
		If (Position:C15($0[[$vlChar]]; " !&()-{}:;<>?/,.=+*")>0)
			$0[[$vlChar+1]]:=Uppercase:C13($0[[$vlChar+1]])
		End if 
	End for 
End if 
