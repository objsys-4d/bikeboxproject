//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/09/21, 21:27:55
// ----------------------------------------------------
// Method: ObjForm_SubformLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $referer; vtNavBtnTxt)
vSelPosn:=0
vlCustomerID:=0
vlItemID:=0
vlSupplierID:=0
vlInvoiceID:=0

$referer:=$1
OBJECT SET VISIBLE:C603(*; "wa_url"; $referer="Shipping")
OBJECT SET VISIBLE:C603(*; "navBtn_@"; True:C214)
OBJECT SET ENABLED:C1123(*; "navBtn_@"; True:C214)
OBJECT SET ENABLED:C1123(*; "navBtn_S@"; vSelPosn#0)
CustinvoiceItemslb:=Null:C1517

If (vtNavBtnTxt="Add") | (vtNavBtnTxt="Edit")  //we are in the middle of adding/editing record, did not hit SAVE
	vtNavBtnTxt:=""
	OBJECT SET VISIBLE:C603(*; "actBtn_@"; False:C215)
	REJECT:C38
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
End if 

Case of 
	: ($referer="Person")
		Form:C1466.person_data:=ds:C1482.Person.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.person_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Person:15]; "personSubform")
		
	: ($referer="Company")
		Form:C1466.company_data:=ds:C1482.Company.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.company_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Company:16]; "companySubform")
		
	: ($referer="Donations")
		Form:C1466.person_data:=ds:C1482.Person.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.person_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Donation:20]; "donationSubform")
		
	: ($referer="Events")
		Form:C1466.event_data:=ds:C1482.Event.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.event_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Event:21]; "eventSubform")
		
	: ($referer="Merchandise")
		Form:C1466.merchandise_data:=ds:C1482.Merchandise.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.merchandise_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Merchandise:17]; "merchSubform")
		
	: ($referer="Order")
		Form:C1466.order_data:=ds:C1482.Order.all()
		Form:C1466.mainSubform:=New object:C1471("data_list"; Form:C1466.order_data)
		OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Order:18]; "orderSubform")
End case 
