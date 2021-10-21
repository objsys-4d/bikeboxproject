//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/19/21, 17:43:42
// ----------------------------------------------------
// Method: EmailSend_CleanUp
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $email; $emailBuild; $SingleEmail; $0)
C_BOOLEAN:C305($blCheckSelf)
$email:=$1
$email:=Replace string:C233($email; ","; ";")

If (Position:C15(";"; $email)#0)
	
	While ($email#"")
		If (Position:C15(";"; $email)=0)
			$SingleEmail:=$email
			$email:=""
		Else 
			$SingleEmail:=Substring:C12($email; 1; Position:C15(";"; $email)-1)
			$email:=Substring:C12($email; Position:C15(";"; $email)+1)
		End if 
		
		$SingleEmail:=UTIL_DropSpaces($SingleEmail)
		If ($SingleEmail#"")
			If ($emailBuild="")
				$emailBuild:=$SingleEmail
			Else 
				$emailBuild:=$emailBuild+"; "+$SingleEmail
			End if 
		End if 
		
	End while 
	
	$0:=$emailBuild
Else 
	$0:=$email
End if 