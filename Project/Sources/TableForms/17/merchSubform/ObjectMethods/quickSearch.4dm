If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	$key:=Character code:C91(Keystroke:C390)
	
	If ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
		GOTO OBJECT:C206(*; "itemOutput_lb")
	End if 
Else 
	$text:=Form:C1466.merchOutput_lb.text
End if 
Form:C1466.merchOutput_lb.data:=ds:C1482.Merchandise.query("merchName = :1 or variant = :1"; "@"+$text+"@")