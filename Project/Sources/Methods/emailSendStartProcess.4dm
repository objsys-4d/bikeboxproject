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
C_BLOB:C604($BlobContainter)
If (Count parameters:C259=1)
	$oMailSendInfo:=$1
End if 
If (Count parameters:C259=2)
	$BlobContainter:=$2
End if 

$vlNewProcess:=New process:C317("emailSendStart"; 0; "emailSendStart"; $oMailSendInfo; $BlobContainter)
