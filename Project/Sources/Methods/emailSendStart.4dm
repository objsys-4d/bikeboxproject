//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 22:22:25
// ----------------------------------------------------
// Method: emailSendStart
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1; voMailSendInfo)
voMailSendInfo:=$1

$vlWindow:=Open form window:C675("emailSend"; Plain form window:K39:10; Horizontally centered:K39:1; At the top:K39:5)
SET WINDOW TITLE:C213("Email Send"; $lEventManagerWin)
DIALOG:C40("emailSend")

voMailSendInfo:=Null:C1517  //clear
