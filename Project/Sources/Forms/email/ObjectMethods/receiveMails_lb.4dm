
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Form:C1466.receiveMails_lb.curPos=0)
			OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
			vtMail_From:=""
			vtMail_To:=""
			vtMail_CC:=""
			vtMail_Subject:=""
			vtMail_DateSend:=""
			vtMail_Body:=""
			OBJECT SET VISIBLE:C603(*; "web area"; False:C215)
			OBJECT SET VISIBLE:C603(*; "input"; True:C214)
			
		Else 
			DisplayAttachments(Form:C1466.receiveMails_lb.curItem.attachments)
			ShowBody(DisplayEmailBody(Form:C1466.receiveMails_lb.curItem))
			
			OBJECT SET ENABLED:C1123(*; "btMail_@"; True:C214)
			vtMail_From:=DisplayEmailAddresses(Form:C1466.receiveMails_lb.curItem.from)
			vtMail_To:=DisplayEmailAddresses(Form:C1466.receiveMails_lb.curItem.to)
			vtMail_CC:=DisplayEmailAddresses(Form:C1466.receiveMails_lb.curItem.cc)
			vtMail_Subject:=Form:C1466.receiveMails_lb.curItem.subject
			vtMail_DateSend:=String:C10(Date:C102(Form:C1466.receiveMails_lb.curItem.sendAt); Date RFC 1123:K1:11; Time:C179(Form:C1466.receiveMails_lb.curItem.sendAt))
		End if 
		
End case 
