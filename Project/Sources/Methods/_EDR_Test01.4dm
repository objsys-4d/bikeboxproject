//%attributes = {}
TRACE:C157


C_OBJECT:C1216($oBox; $oBoxList; $oInbox)
C_COLLECTION:C1488($cBoxList)
C_BOOLEAN:C305($proceed)

$server:=New object:C1471
//$server.host:="imap.gmail.com"
//$server.port:=993
//$server.user:="captjackvm@gmail.com"  //"edureyesjr@gmail.com"
//$server.password:="cjnc0918"  //<>EDRPwd

$server.host:=<>Email_Hostname  //"outlook.office365.com"
$server.port:=<>Email_Port  //993
$server.user:=<>Email_UserName  //"developer@objectivesystems.com"
$server.password:=<>Email_Password  //"0bjSys4D!"
$server.acceptUnsecureConnection:=<>Email_Security  //TLS - false  ,  SSL - true


// Create a transporter from your server information
$IMAP_Transporter:=IMAP New transporter:C1723($server)

$cBoxList:=$IMAP_Transporter.getBoxList()
$colctr:=$cBoxList.count()

For ($i; 1; $colctr)
	$oInbox:=$cBoxList[$i-1]
	
	If ($oInbox.name="Inbox")
		$i:=$colctr
		$proceed:=True:C214
	End if 
	
End for 

If ($proceed)
	$boxInfo:=$IMAP_Transporter.selectBox($oInbox.name)
	$mail:=$IMAP_Transporter.getMail($boxInfo.mailCount)
	
	For ($j; 1; $boxInfo.mailCount)
		$email:=$IMAP_Transporter.getMail($j)
	End for 
	
	
End if 