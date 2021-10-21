

GEN_Message("open"; "Deleting messages...")
$dEmails:=Form:C1466.receiveMails_lb.curSel
$mailIds:=New collection:C1472
For each ($loop; $dEmails)
	$mailIds.push(New collection:C1472($loop.id))
End for each 

//$idx:=FindMailIndex(Form.receiveMails_lb.data; $mailIds[0])

$status:=voIMAP_Transporter.delete($mailIds)

If ($status.success)
	//GEN_Message("open"; "Connecting to Mail server...")
	//voIMAP_Transporter:=Null
	//voIMAP_Transporter:=Email_InitTransporter
	GEN_Message("update"; "Refreshing list...            "; 1; 2)
	//Email_InitMailboxes(voIMAP_Transporter)
	
	
	$status:=voIMAP_Transporter.expunge()
	For each ($loop; $dEmails)
		$idx:=Form:C1466.receiveMails_lb.data.findIndex("FindMailIndex"; $loop.id)
		Form:C1466.receiveMails_lb.data:=Form:C1466.receiveMails_lb.data.remove($idx)
	End for each 
	
	$elem:=Find in array:C230(arMailboxName; vtCurrentBox)
	If ($elem#-1)
		LISTBOX SELECT ROW:C912(lbBoxNames; $elem)
	End if 
	vtMessageCountText:=String:C10(Form:C1466.receiveMails_lb.data.length)+" messages."
	LISTBOX SELECT ROW:C912(*; "receiveMails_lb"; 0; lk remove from selection:K53:3)  //no selection
	
End if 

GEN_Message("close")

