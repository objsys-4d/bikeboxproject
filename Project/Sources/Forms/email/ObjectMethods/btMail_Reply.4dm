
$oMailInfo:=New object:C1471
$oMailInfo.recipient:=vtMail_From
$oMailInfo.cc:=vtMail_CC
$oMailInfo.subject:=vtMail_Subject
$oMailInfo.type:="reply"
$oMailInfo.bodyType:=vtMail_BodyType

emailSendStartProcess($oMailInfo)