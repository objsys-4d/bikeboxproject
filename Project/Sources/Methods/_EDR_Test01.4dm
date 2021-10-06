//%attributes = {}
TRACE:C157
C_OBJECT:C1216($oPsn; $oPrn)
//$oPrn.companyID:=3
$oPsn:=ds:C1482.Company.query("companyID = :1"; 3)  //.first()


//$oOrder:=ds.Order.all()
//$oOrderPerson:=$oOrder.order_Person

//$text:="e@"
//$ord:=$oOrderPerson.query("lastName = :1"; "@"+$text+"@")

//$UUID:="2459FE8EAC1237488F5078DCB7FD075B"

//$oOrd:=ds.Order.get($UUID)
//$oOrdItem:=$oOrd.Order_OrderItem

//var $person : cs.PersonEntity
//$person:=ds.Person.all().first()  //get an entity

//SearchTest($person; "Edu")

