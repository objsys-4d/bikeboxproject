
If (Form event code:C388=On Selection Change:K2:29)
	//Form.receiveMails.downloadMail(Form.mail)
	DisplayAttachments(Form:C1466.receiveMails_lb.curItem.attachments)
	ShowBody(DisplayEmailBody(Form:C1466.receiveMails_lb.curItem))
	
	If (Form:C1466.receiveMails_lb.curPos=0)
		OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(*; "btMail_@"; True:C214)
	End if 
	
End if 