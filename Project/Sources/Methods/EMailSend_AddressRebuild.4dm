//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/16/21, 00:40:01
// ----------------------------------------------------
// Method: EMailSend_AddressRebuild
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $emailss)
$emailss:=$1

If (Position:C15(";"; $emails)#0)
	
	While ($emails#"")
		If (Position:C15(";"; $emails)=0)
			$SingleEmail:=$emails
			$emails:=""
		Else 
			$SingleEmail:=Substring:C12($emails; 1; Position:C15(";"; $emails)-1)
			$emails:=Substring:C12($emails; Position:C15(";"; $emails)+1)
		End if 
		
		
	End while 
End if 