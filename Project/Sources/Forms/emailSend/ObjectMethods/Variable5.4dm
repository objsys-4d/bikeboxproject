Case of 
	: (Form event code:C388=On After Keystroke:K2:26)
		GET HIGHLIGHT:C209(vtEmailSend_To; $startSel; $endSel)
		If ($startSel#0)
			vtKey:=""
		End if 
		
		$key:=Character code:C91(Keystroke:C390)
		Case of 
			: ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
				vtKey:=""
				vblListDisplayed:=True:C214
				LISTBOX SELECT ROW:C912(*; "emailList_lb"; 1; lk replace selection:K53:1)  //no selection
				GOTO OBJECT:C206(*; "emailList_lb")
			Else 
				
				If (Get edited text:C655="")
					vtEmailSend_To:=""
					ARRAY TEXT:C222(atEmailSendTo; 0)  //clear the array of all names are removed
					vtKey:=""
				Else 
					Case of 
						: ($key=Backspace key:K12:29)
							vtKey:=Substring:C12(vtKey; 1; Length:C16(vtKey)-1)
							
						: ($key=DEL ASCII code:K15:34)
							
						Else 
							vtKey:=vtKey+Char:C90($key)
					End case 
					EmailSend_AddressLookAhead(vtKey)
				End if   //get edited text
				
				
		End case 
		
End case 