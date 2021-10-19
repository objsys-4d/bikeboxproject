CONFIRM:C162("Mark selected emails as Not Junk and move to Inbox?")
If (OK=1)
	$dEmails:=Form:C1466.receiveMails_lb.curSel
	$mailIds:=New collection:C1472
	For each ($loop; $dEmails)
		$mailIds.push(New collection:C1472($loop.id))
	End for each 
	$status:=voIMAP_Transporter.move($mailIds; "Inbox")
	
	If ($status.success)
		//remove from listbox
		For each ($loop; $dEmails)
			$idx:=Form:C1466.receiveMails_lb.data.findIndex("FindMailIndex"; $loop.id)
			Form:C1466.receiveMails_lb.data:=Form:C1466.receiveMails_lb.data.remove($idx)
		End for each 
		vtMessageCountText:=String:C10(Form:C1466.receiveMails_lb.data.length)+" messages."
	End if 
End if 