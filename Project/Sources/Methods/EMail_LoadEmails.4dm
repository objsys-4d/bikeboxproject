//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 20:17:17
// ----------------------------------------------------
// Method: EMail_LoadEmails
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $mailboxName; vtMessageCountText)
C_OBJECT:C1216($boxInfo)
$mailboxName:=$1

$boxInfo:=voIMAP_Transporter.selectBox($mailboxName)

GEN_Message("open"; "Retrieving emails...")


If ($boxInfo.mailCount=0)
	
	vtMessageCountText:=""
	Form:C1466.receiveMails_lb.data:=Null:C1517
Else 
	
	$oMailObject:=New object:C1471
	$oMailObject:=voIMAP_Transporter.getMails(1; $boxInfo.mailCount)
	$oEmails:=$oMailObject.list
	For each ($loop; $oEmails)
		
		$loop.receivedDate:=Date:C102($loop.receivedAt)
		$loop.fromMail:=DisplayEmailAddresses($loop.from)
		
	End for each 
	
	<>CollEmailList:=New collection:C1472
	<>CollEmailList:=$oEmails.extract("fromMail").distinct()
	
	//extract person record 
	C_LONGINT:C283($procID)
	$procID:=New process:C317("Email_ExtractPerson"; 0; "Extract Person from Email"; <>CollEmailList)
	
	Form:C1466.receiveMails_lb.data:=$oEmails
	vtMessageCountText:=String:C10($boxInfo.mailCount)+" messages."
	
	Form:C1466.receiveMails_lb.data:=Form:C1466.receiveMails_lb.data.orderBy("receivedAt desc")
End if 

GEN_Message("close")

OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
LISTBOX SELECT ROW:C912(*; "receiveMails_lb"; 0; lk remove from selection:K53:3)  //no selection


