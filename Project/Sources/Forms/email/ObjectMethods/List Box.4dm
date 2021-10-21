Case of 
	: (Form event code:C388=On Clicked:K2:4)
		vtMail_From:=""
		vtMail_To:=""
		vtMail_CC:=""
		vtMail_Subject:=""
		vtMail_DateSend:=""
		vtMail_Body:=""
		OBJECT SET VISIBLE:C603(*; "web area"; False:C215)
		OBJECT SET VISIBLE:C603(*; "input"; True:C214)
		
		If (arMailboxName{lbBoxNames}="")
			Form:C1466.receiveMails_lb.data:=Null:C1517
			vtMessageCountText:=""
			vtCurrentBox:=""
		Else 
			If (vtCurrentBox#arMailboxName{lbBoxNames})  //do not run again if you are in the same mailbox
				vtCurrentBox:=arMailboxName{lbBoxNames}
				EMail_LoadEmails(vtCurrentBox)
			End if 
			
			If (vtCurrentBox="Junk@")
				OBJECT SET VISIBLE:C603(btnotJunk; True:C214)
				OBJECT SET ENABLED:C1123(btnotJunk; False:C215)  //disable by default
			Else 
				OBJECT SET VISIBLE:C603(btnotJunk; True:C214)
			End if 
		End if 
		OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
		
End case 