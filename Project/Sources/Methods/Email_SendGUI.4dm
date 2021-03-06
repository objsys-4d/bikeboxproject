//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 22:33:13
// ----------------------------------------------------
// Method: Email_SendGUI
// Description
// 
//
// Parameters
// ----------------------------------------------------

//new way to send e-mail with Transporter
//https://doc.4d.com/4Dv18R3/4D/18-R3/Email-object.300-4900452.en.html
//https://doc.4d.com/4Dv18R3/4D/18-R3/MAIL-New-attachment.301-4900471.en.html


C_TEXT:C284($from; $user; $host; $pass; $replyto; $from)
C_TEXT:C284($to; $vtSubject; $message)
C_LONGINT:C283($error; $smtp_id)
C_BOOLEAN:C305($html; vbTest)
C_OBJECT:C1216($email; $server; $transporter; $status)

$server:=New object:C1471
$server.host:="smtp.office365.com"  //
$server.user:="developer@objectivesystems.com"
$server.password:="0bjSys4D!"
$server.port:=587

$transporter:=SMTP New transporter:C1608($server)
$email:=New object:C1471

//vbTest:=True
$from:=$server.user
$replyto:=$server.user


If ((Count parameters:C259>=3) | (vbTest))
	
	If (vbTest)
		//values are set
		$to:="edureyesjr@objectivesystems.com, mikebeatty@objectivesystems.com"
		$vtSubject:="ModernStatesTest"
		$message:=$vtSubject+String:C10(Timestamp:C1445)
	Else 
		$to:=$1
		$vtSubject:=$2
		$message:=$3
	End if 
	
	If (Count parameters:C259>=4)
		If ($4#"")
			$from:=$4
		End if 
	End if 
	
	If (Count parameters:C259>=5)
		If ($5#"")
			$replyto:=$5
		End if 
	End if 
	
	If (Count parameters:C259>=6)
		$html:=$6
	End if 
	
	If ($replyto="")
		$replyto:=$from
	End if 
	
	$email.from:=$from
	$email.replyTo:=$replyto
	$email.to:=$to
	$email.subject:=$vtSubject
	
	If ($html)
		$email.htmlBody:=$message
	Else 
		$email.textBody:=$message
	End if 
	
	//{success:true,status:250,statusText:2.6.0 <0066A48D5928B641BE9448D1F0A8741E@adreima.com> [InternalId=139333034049617, Hostname=PHX-EXCHHYB2-P.arm.local] 1142 bytes in 0.199, 5.598 KB/sec Queued mail for delivery}
	//{success:false,status:0,statusText:Failed to send message.}
	$status:=$transporter.send($email)
	
	If ($status.success)
		$error:=0
	Else 
		//If (Not($status.success))
		//ALERT("An error occurred sending the mail: "+$status.statusText)
		$error:=-1
		
	End if 
	
Else 
	//email can not be sent
	$error:=-1
End if 

$0:=$error
