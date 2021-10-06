If (Form event code:C388=On After Keystroke:K2:26)
	$text:=Get edited text:C655
	$key:=Character code:C91(Keystroke:C390)
	
	If ($key=Down arrow key:K12:19) | ($key=Up arrow key:K12:18)
		GOTO OBJECT:C206(*; "orderOutput_lb")
	End if 
Else 
	$text:=Form:C1466.orderOutput_lb.text
End if 

//we want to query orders based on either person information in person or address infor in order
$text:="@"+$text+"@"
$objPerson:=ds:C1482.Person.query("lastName = :1 or firstName = :1"; $text)
$objPersonOrder:=$objPerson.Person_Order

$objOrder:=ds:C1482.Order.query("address = :1 or city = :1 or state = :1"; "@"+$text+"@")

$objMerge:=$objPersonOrder.or($objOrder)

Form:C1466.orderOutput_lb.data:=$objMerge
//$oOrderPerson:=Form.orderOutput_lb.data.order_Person
//$oOrderPerson.lastName = :1 or $oOrderPerson.firstName = :1 or 
//Form.orderOutput_lb.data:=ds.Order.query("$oOrderPerson.lastName = :1 or $oOrderPerson.firstName = :1 or address = :1 or city = :1 or state = :1"; "@"+$text+"@")
//Form.orderOutput_lb.data:=ds.Order.query("address = :1 or city = :1 or state = :1"; "@"+$text+"@")