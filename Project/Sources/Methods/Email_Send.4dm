//%attributes = {"shared":true}
//new way to send e-mail with Transporter
//https://doc.4d.com/4Dv18R3/4D/18-R3/Email-object.300-4900452.en.html
//https://doc.4d.com/4Dv18R3/4D/18-R3/MAIL-New-attachment.301-4900471.en.html


C_TEXT:C284($from; $user; $host; $pass; $replyto; $from)
C_TEXT:C284($to; $vtSubject; $message)
C_LONGINT:C283($error; $smtp_id; $attachCount)
C_BOOLEAN:C305($html; vbTest)
C_OBJECT:C1216($email; $server; $transporter; $status)
C_BLOB:C604($attachmentBLOB)

$server:=New object:C1471
$server.host:=<>SMTP_Hostname
$server.user:=<>SMTP_UserName
$server.password:=<>SMTP_Password
$server.port:=<>SMTP_Port

$transporter:=SMTP New transporter:C1608($server)
$email:=New object:C1471

//vbTest:=True
$from:=$server.user
$replyto:=$server.user


If ((Count parameters:C259>=3) | (vbTest))
	
	If (vbTest)
		//values are set
		$to:="edureyesjr@objectivesystems.com; mikebeatty@objectivesystems.com"
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
	
	If (Count parameters:C259>=7)
		$attachmentBLOB:=$7
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
	
	//attachment
	If (BLOB size:C605($attachmentBLOB)#0)
		ARRAY TEXT:C222(atAttachments; 0)
		ARRAY TEXT:C222(atAttachmentsPath; 0)
		ARRAY TEXT:C222(atAttachmentsType; 0)
		ARRAY BLOB:C1222(atAttachmentsBLOB; 0)
		BLOB_BLOBToVars(->$attachmentBLOB; ->atAttachments; ->atAttachmentsPath; ->atAttachmentsType; ->atAttachmentsBLOB)
		For ($i; 1; Size of array:C274(atAttachments))
			Case of 
				: (atAttachmentsType{$i}="file")
					If ($i=1)
						$email.attachments:=New collection:C1472(MAIL New attachment:C1644(atAttachmentsPath{$i}))
					Else 
						$email.attachments[$i-1]:=MAIL New attachment:C1644(atAttachmentsPath{$i})
					End if 
				: (atAttachmentsType{$i}="blob")
					If ($i=1)
						$email.attachments:=New collection:C1472(MAIL New attachment:C1644(atAttachmentsBLOB{$i}; atAttachments{$i}))
					Else 
						$email.attachments[$i-1]:=MAIL New attachment:C1644(atAttachmentsBLOB{$i}; atAttachments{$i})
					End if 
					
			End case 
		End for 
	End if 
	
	
	//C_BLOB($attachBLOB)
	//$attachCount:=$attachmentsColl.length
	//If ($attachCount>0)
	//$loop:=$attachCount-1
	
	//Case of 
	//: ($attachmentsColl[0].filePath#"")
	//$email.attachments:=New collection(MAIL New attachment($attachmentsColl[0].filePath))
	
	//: ($attachmentsColl[0].attachBLOBTxt#"")
	//TEXT TO BLOB($attachmentsColl[0].attachBLOBTxt; $attachBLOB; UTF8 text without length)
	//$email.attachments:=New collection(MAIL New attachment($attachBLOB); $attachmentsColl[0].fileName)
	//End case 
	//For ($a; 1; $loop)
	//Case of 
	//: ($attachmentsColl[$a].filePath#"")
	//$email.attachments[$a]:=MAIL New attachment($attachmentsColl[$a].filePath)
	
	//: ($attachmentsColl[$a].attachBLOBTxt#"")
	//TEXT TO BLOB($attachmentsColl[$a].attachBLOBTxt; $attachBLOB; UTF8 text without length)
	//$email.attachments[$a]:=MAIL New attachment($attachBLOB; $attachmentsColl[$a].fileName)
	
	//End case 
	//End for 
	//End if 
	
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
