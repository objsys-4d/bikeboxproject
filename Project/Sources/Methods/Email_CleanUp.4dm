//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/11/21, 21:17:46
// ----------------------------------------------------
// Method: Email_CleanUp
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $email; $emailBuild; $SingleEmail; $0)
C_BOOLEAN:C305($blCheckSelf)
$email:=$1
$email:=Replace string:C233($email; ","; ";")

If (Count parameters:C259=2)
	$blCheckSelf:=True:C214
End if 

If (Position:C15(";"; $email)#0)
	
	While ($email#"")
		If (Position:C15(";"; $email)=0)
			$SingleEmail:=$email
			$email:=""
		Else 
			$SingleEmail:=Substring:C12($email; 1; Position:C15(";"; $email)-1)
			$email:=Substring:C12($email; Position:C15(";"; $email)+1)
		End if 
		
		If ($blCheckSelf)  //used in 'reply all'
			If (Position:C15(<>Email_UserName; $SingleEmail)=0)
				$proceed:=True:C214
			Else 
				$proceed:=False:C215
			End if 
		Else 
			$proceed:=True:C214
		End if 
		
		If ($proceed)
			$SingleEmail:=UTIL_DropSpaces($SingleEmail)
			If ($emailBuild="")
				$emailBuild:=$SingleEmail
			Else 
				
				If (Position:C15($SingleEmail; $emailBuild)=0)  //make sure there are no duplicate email addresses
					$emailBuild:=$emailBuild+"; "+$SingleEmail
				End if 
			End if 
			
		End if 
		
	End while 
	
	$0:=$emailBuild
Else 
	$0:=$email
End if 


