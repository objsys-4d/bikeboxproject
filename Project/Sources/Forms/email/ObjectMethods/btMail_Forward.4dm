
$oMailInfo:=New object:C1471
$oMailInfo.recipient:=""
$oMailInfo.cc:=vtMail_CC
$oMailInfo.subject:=vtMail_Subject
$oMailInfo.type:="forward"
$oMailInfo.message:=vtMail_Body
$oMailInfo.bodyType:=vtMail_BodyType
emailSendStartProcess($oMailInfo)