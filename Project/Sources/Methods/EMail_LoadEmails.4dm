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
GEN_Message("update"; String:C10($j)+" of "+String:C10($boxInfo.mailCount)+"                                 "; 1; 2)


If ($boxInfo.mailCount=0)
	
	vtMessageCountText:=""
	Form:C1466.receiveMails_lb.mails:=Null:C1517
Else 
	
	$oMailObject:=New object:C1471
	$oMailObject:=voIMAP_Transporter.getMails(1; $boxInfo.mailCount)
	$oEmails:=$oMailObject.list
	For each ($loop; $oEmails)
		
		$loop.receivedDate:=Date:C102($loop.receivedAt)
		
	End for each 
	
	Form:C1466.receiveMails_lb.mails:=$oEmails
	vtMessageCountText:=String:C10($boxInfo.mailCount)+" messages."
	
	LISTBOX SORT COLUMNS:C916(*; "receiveMails_lb"; 1; <)  //sort by received Date
End if 

GEN_Message("close")

LISTBOX SELECT ROW:C912(receiveMails_lb; 0; lk replace selection:K53:1)
OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)


