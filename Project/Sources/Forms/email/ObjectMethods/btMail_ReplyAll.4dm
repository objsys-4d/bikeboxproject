C_TEXT:C284($MailTo; $emailAddrs)

$MailTo:=Email_CleanUp(vtMail_To; True:C214)  //clean up to remove sender account

$oMailInfo:=New object:C1471
If (vtMail_CC="")
	$emailAddrs:=vtMail_From+"; "+$MailTo
Else 
	$emailAddrs:=vtMail_From+"; "+vtMail_CC+"; "+$MailTo
End if 

$emailAddrs:=Email_CleanUp($emailAddrs)  //cleanup to remove duplicates

$oMailInfo.recipient:=$emailAddrs
$oMailInfo.subject:=vtMail_Subject
$oMailInfo.type:="reply all"
$oMailInfo.bodyType:=vtMail_BodyType
emailSendStartProcess($oMailInfo)