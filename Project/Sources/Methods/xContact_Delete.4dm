//%attributes = {"shared":true}
C_OBJECT:C1216($oContact)  // CONTACT

C_OBJECT:C1216($oSelected)  // SELECTED RECORD

C_TEXT:C284($txtDialog_Content)  // DIALOG CONTENT

Case of 
		
	: (oConnection.selected.length=0)
		
		$txtDialog_Content:=Ltg_Str_Localise ("%please_select_one_or_more_records_and_try_again")
		
		  // OPEN CONFIRMATION DIALOG
		
		Ltg_JS_Send ("ltgDialogOpen('contact-delete')")
		
		  // DISABLE "DELETE" BUTTON
		
		Ltg_JS_Send ("ltgObj('button-delete').attr('disabled',true)")
		
		  // UPDATE DIALOG CONTENT
		
		Ltg_JS_Send ("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
		
		  // SEND BACK THE JAVASCRIPT ONLY
		
		oConnection.responseType:="javascript"
		
	: (oConnection.action="delete-confirm")
		
		$txtDialog_Content:=Ltg_Str_Localise ("%delete")+" "+String:C10(oConnection.selected.length)+" "+Ltg_Str_Localise ("%contacts")+"?"
		
		  // OPEN CONFIRMATION DIALOG
		
		Ltg_JS_Send ("ltgDialogOpen('contact-delete')")
		
		  // ENABLE "DELETE" BUTTON
		
		Ltg_JS_Send ("ltgObj('button-delete').attr('disabled',false)")
		
		Ltg_JS_Send ("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
		
		  // SEND BACK THE JAVASCRIPT ONLY
		
		oConnection.responseType:="javascript"
		
	: (oConnection.action="delete")
		
		For each ($oSelected;oConnection.selected)
			
			$oContact:=ds:C1482.Contacts.get($oSelected.record)
			
			If ($oContact#Null:C1517)
				
				$oContact.drop()
			End if 
		End for each 
		
		  // CLEAR SELECTION
		
		oConnection.selected:=New collection:C1472
		
		  // CLOSE CONFIRMATION DIALOG
		
		Ltg_JS_Send ("ltgDialogClose('contact-delete')")
End case 
