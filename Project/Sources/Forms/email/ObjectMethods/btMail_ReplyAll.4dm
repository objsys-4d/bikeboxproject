C_TEXT:C284($MailTo; $emailAddresses)

$MailTo:=Email_CleanUp(vtMail_To; True:C214)  //clean up to remove sender account

$oMailInfo:=New object:C1471
If (vtMail_CC="")
	$emailAddresses:=vtMail_From+"; "+$MailTo
Else 
	$emailAddresses:=vtMail_From+"; "+vtMail_CC+"; "+$MailTo
End if 

$emailAddresses:=Email_CleanUp($emailAddresses)  //cleanup to remove duplicates

$oMailInfo.recipient:=$emailAddresses
$oMailInfo.subject:=vtMail_Subject
$oMailInfo.type:="reply all"
$oMailInfo.message:=vtMail_Body
$oMailInfo.bodyType:=vtMail_BodyType
$oMailInfo.from:=UTIL_DropSpaces(vtMail_From)
$oMailInfo.to:=UTIL_DropSpaces(vtMail_To)
$oMailInfo.dateInfo:=vtMail_DateSend
emailSendStartProcess($oMailInfo)