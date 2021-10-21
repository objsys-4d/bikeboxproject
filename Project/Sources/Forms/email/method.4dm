Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY BOOLEAN:C223(lbBoxNames; 0)
		C_TEXT:C284(vtMessageCountText; vtCurrentBox)
		C_BLOB:C604(vbBlankBlob)
		GEN_ListBox_AllItemsSelect(->lbBoxNames; False:C215)
		Output_lbInit("receiveMails_lb")
		
		C_OBJECT:C1216(voIMAP_Transporter)
		GEN_Message("open"; "Connecting to Mail server...")
		voIMAP_Transporter:=Email_InitTransporter
		If (voIMAP_Transporter=Null:C1517)
			ALERT:C41("An error occured.")
		Else 
			GEN_Message("update"; "Initializing mailboxes...            "; 1; 2)
			Email_InitMailboxes(voIMAP_Transporter)
		End if 
		
		GEN_Message("close")
		
		OBJECT SET ENABLED:C1123(*; "btMail_@"; False:C215)
		vtMessageCountText:=""
		
		If (Size of array:C274(arMailboxName)#0)
			EMail_LoadEmails("Inbox")
			vtCurrentBox:="Inbox"
			$elem:=Find in array:C230(arMailboxName; "Inbox")
			If ($elem#-1)
				LISTBOX SELECT ROW:C912(lbBoxNames; $elem)
			End if 
		End if 
		
		//mail info
		C_TEXT:C284(vtMail_From; vtMail_To; vtMail_CC; vtMail_DateSend; vtMail_Body; vtMail_Subject; vtMail_BodyType)
		vtMail_From:=""
		vtMail_To:=""
		vtMail_CC:=""
		vtMail_Subject:=""
		vtMail_DateSend:=""
		vtMail_Body:=""
		vtMail_BodyType:=""
		
End case 