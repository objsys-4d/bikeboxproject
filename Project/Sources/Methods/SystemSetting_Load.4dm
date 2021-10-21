//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 00:54:11
// ----------------------------------------------------
// Method: SystemSetting_Load
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($oSysSettings)
$oSysSettings:=ds:C1482.SystemSetting.all()
C_TEXT:C284(<>Sys_CompanyName; <>Sys_Address; <>Sys_City; <>Sys_State; <>Sys_Phone1; <>Sys_Phone2; <>Sys_Fax; <>Sys_EmailAddress; <>Sys_Website)
<>Sys_CompanyName:=$oSysSettings[0].companyName
<>Sys_Address:=$oSysSettings[0].address
<>Sys_City:=$oSysSettings[0].city
<>Sys_State:=$oSysSettings[0].state
<>Sys_Phone1:=$oSysSettings[0].phone1
<>Sys_Phone2:=$oSysSettings[0].phone2
<>Sys_Fax:=$oSysSettings[0].fax
<>Sys_EmailAddress:=$oSysSettings[0].emailAddress
<>Sys_Website:=$oSysSettings[0].website


//email settings - IMAP
C_TEXT:C284(<>IMAP_Hostname; <>IMAP_Port; <>IMAP_UserName; <>IMAP_Password)
C_BOOLEAN:C305(<>IMAP_Security)
<>IMAP_Hostname:=$oSysSettings[0].IMAP_hostName
<>IMAP_Port:=$oSysSettings[0].IMAP_port
<>IMAP_UserName:=$oSysSettings[0].IMAP_userName
<>IMAP_Password:=$oSysSettings[0].IMAP_password
<>IMAP_Security:=$oSysSettings[0].IMAP_security

//email settings - IMAP
C_TEXT:C284(<>SMTP_Hostname; <>SMTP_Port; <>SMTP_UserName; <>SMTP_Password)
C_BOOLEAN:C305(<>SMTP_Security)
<>SMTP_Hostname:=$oSysSettings[0].SMTP_hostName
<>SMTP_Port:=$oSysSettings[0].SMTP_port
<>SMTP_UserName:=$oSysSettings[0].SMTP_userName
<>SMTP_Password:=$oSysSettings[0].SMTP_password
<>SMTP_Security:=$oSysSettings[0].SMTP_security
