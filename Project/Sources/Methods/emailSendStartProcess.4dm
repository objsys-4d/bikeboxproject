//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 22:22:18
// ----------------------------------------------------
// Method: emailSendStartProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($1; $oMailSendInfo)
If (Count parameters:C259=1)
	$oMailSendInfo:=$1
End if 

$vlNewProcess:=New process:C317("emailSendStart"; 0; "emailSendStart"; $oMailSendInfo)
