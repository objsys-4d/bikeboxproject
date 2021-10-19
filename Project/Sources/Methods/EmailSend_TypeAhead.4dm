//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/19/21, 19:17:59
// ----------------------------------------------------
// Method: EmailSend_TypeAhead
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; vPtremailField)
vPtremailField:=$1
$key:=Character code:C91(Keystroke:C390)
Case of 
	: ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
		vtKey:=""
		vblListDisplayed:=True:C214
		LISTBOX SELECT ROW:C912(*; "emailList_lb"; 1; lk replace selection:K53:1)  //no selection
		GOTO OBJECT:C206(*; "emailList_lb")
	Else 
		
		If (Get edited text:C655="")
			Self:C308->:=""
			vtEmailSend_Temp:=""
			vtKey:=""
		Else 
			Self:C308->:=Get edited text:C655
			Case of 
				: ($key=Backspace key:K12:29)
					//vtKey:=Substring(vtKey; 1; Length(vtKey)-1)
					vtEmailSend_Temp:=Get edited text:C655
					vtKey:=""
					
				: ($key=DEL ASCII code:K15:34)
					vtEmailSend_Temp:=Get edited text:C655
					vtKey:=""
					
				: (Char:C90($key)=";")
					vtEmailSend_Temp:=Get edited text:C655
					vtKey:=""
					
				Else 
					vtKey:=vtKey+Char:C90($key)
			End case 
			EmailSend_AddressLookAhead(vtKey)
		End if   //get edited text
End case 
