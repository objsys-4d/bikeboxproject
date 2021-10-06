If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	$key:=Character code:C91(Keystroke:C390)
	
	If ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
		GOTO OBJECT:C206(*; "itemOutput_lb")
	End if 
Else 
	$text:=Form:C1466.personOutput_lb.text
End if 
Form:C1466.personOutput_lb.data:=ds:C1482.Person.query("lastName = :1 or firstName = :1 or address1 = :1 or country = :1 or email = :1"; "@"+$text+"@")