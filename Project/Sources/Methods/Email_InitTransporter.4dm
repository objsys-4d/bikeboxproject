//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 18:24:35
// ----------------------------------------------------
// Method: Email_InitTransporter
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($server; $0)

$server:=New object:C1471
$server.host:=<>Email_Hostname  //"outlook.office365.com"
$server.port:=<>Email_Port  //993
$server.user:=<>Email_UserName  //"developer@objectivesystems.com"
$server.password:=<>Email_Password  //"0bjSys4D!"
$server.acceptUnsecureConnection:=<>Email_Security  //TLS - false  ,  SSL - true

// Create a transporter from your server information
$0:=IMAP New transporter:C1723($server)