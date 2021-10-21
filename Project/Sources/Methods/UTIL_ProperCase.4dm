//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 08/16/21, 20:29:41
// ----------------------------------------------------
// Method: UTIL_ProperCase
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $text)
$text:=$1

$text:=UTIL_DropSpaces($text)  //reduce spaces to 1

$text:=UTIL_TitleCase($text)  //capitalize first letter of words/names 

$0:=$text