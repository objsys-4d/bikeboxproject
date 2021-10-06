If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	$key:=Character code:C91(Keystroke:C390)
	
	If ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
		GOTO OBJECT:C206(*; "customerList")
		LISTBOX SELECT ROW:C912(*; "customerList"; 1; 0)
		//OBJECT SET SCROLL POSITION(*; "customerList"; 1)
	End if 
	
Else 
	$text:=Form:C1466.customerSearch
End if 
Form:C1466.companyListlb.data:=ds:C1482.Customer.query("FirstName = :1 or LastName = :1"; $text+"@")

