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


//email settings
C_TEXT:C284(<>Email_Hostname; <>Email_Port; <>Email_UserName; <>Email_Password)
C_BOOLEAN:C305(<>Email_Security)
<>Email_Hostname:=$oSysSettings[0].email_hostName
<>Email_Port:=$oSysSettings[0].email_port
<>Email_UserName:=$oSysSettings[0].email_userName
<>Email_Password:=$oSysSettings[0].email_password
<>Email_Security:=$oSysSettings[0].email_security