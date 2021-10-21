Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (arMailboxName{lbBoxNames}="")
			Form:C1466.receiveMails_lb.mails:=Null:C1517
			vtMessageCountText:=""
			vtCurrentBox:=""
		Else 
			If (vtCurrentBox#arMailboxName{lbBoxNames})  //do not run again if you are in the same mailbox
				vtCurrentBox:=arMailboxName{lbBoxNames}
				EMail_LoadEmails(vtCurrentBox)
			End if 
		End if 
		OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
		
End case 