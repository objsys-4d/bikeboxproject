//%attributes = {"shared":true}
C_OBJECT:C1216($oPerson)  // COMPANY

C_OBJECT:C1216($oSelected)  // SELECTED RECORDS

C_TEXT:C284($txtDialog_Content)  // DIALOG CONTENT

Case of 
		// *** LIST FORM...
		
	: (oConnection.form="personlist.html")
		
		Case of 
			: (oConnection.selected.length=0)
				
				$txtDialog_Content:=Ltg_Str_Localise("%please_select_one_or_more_records_and_try_again")
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('person-delete')")
				
				// DISABLE "DELETE" BUTTON
				
				Ltg_JS_Send("ltgObj('button-delete').attr('disabled',true)")
				
				// UPDATE DIALOG CONTENT
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete-confirm")
				
				$txtDialog_Content:=Ltg_Str_Localise("%delete")+" "+String:C10(oConnection.selected.length)+" "+Ltg_Str_Localise("%person")+" records?"
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('person-delete')")
				
				// ENABLE "DELETE" BUTTON
				
				Ltg_JS_Send("ltgObj('button-delete').attr('disabled',false)")
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete")
				
				For each ($oSelected; oConnection.selected)
					
					$oPerson:=ds:C1482.Person.get($oSelected.record)
					
					If ($oPerson#Null:C1517)
						
						$oPerson.drop()
					End if 
				End for each 
				
				// CLEAR SELECTION
				
				oConnection.selected:=New collection:C1472
				
				// CLOSE CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogClose('person-delete')")
				
		End case 
		
		// *** DETAIL FORM...
		
	: (oConnection.form="persondetail.html")
		
		Case of 
				
			: (oConnection.action="delete-confirm")
				
				$txtDialog_Content:=Ltg_Str_Localise("%delete")+" "+Ltg_Str_Localise("%person")+" record?"
				
				// OPEN CONFIRMATION DIALOG
				
				Ltg_JS_Send("ltgDialogOpen('person-delete')")
				
				// UPDATE DIALOG CONTENT
				
				Ltg_JS_Send("ltgObj('dialog-content').html('"+$txtDialog_Content+"')")
				
				// SEND BACK THE JAVASCRIPT ONLY
				
				oConnection.responseType:="javascript"
				
			: (oConnection.action="delete")
				
				$oPerson:=ds:C1482.Person.get(oConnection.record)
				
				If ($oPerson#Null:C1517)
					
					$oPerson.drop()
				End if 
				
				// PUBLISH THE PERSON LIST FORM...
				
				oConnection.form:="personlist.html"
				oConnection.action:="index"
				
		End case 
End case 
