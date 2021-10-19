//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/16/21, 00:34:30
// ----------------------------------------------------
// Method: EmailSend_AddressLookAhead
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $key)
$key:=$1
If ($key#"")
	C_TEXT:C284($Found)
	$cFound:=New collection:C1472
	Form:C1466.emailList_lb.data:=Null:C1517
	For ($i; 0; <>CollEmailList.length)
		$Found:=<>CollEmailList.find($i; "FindEmail"; $key+"@")
		If ($Found#"")
			$cFound.push($Found)
		End if 
	End for 
	Form:C1466.emailList_lb.data:=$cFound.distinct()
	If ($cFound.length=0) | ($key="")
		OBJECT SET VISIBLE:C603(*; "emailList_lb"; False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*; "emailList_lb"; True:C214)
	End if 
	Case of 
		: (vEmailCurrentField="to")
			OBJECT SET COORDINATES:C1248(*; "emailList_lb"; 127; 32; 484; 152)
			
		: (vEmailCurrentField="cc")
			OBJECT SET COORDINATES:C1248(*; "emailList_lb"; 127; 54; 484; 174)
			
	End case 
End if 