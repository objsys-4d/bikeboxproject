//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 08/31/21, 21:32:10
// ----------------------------------------------------
// Method: ObjForm_ActBtn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $referer; $NavBtnTxt)
$referer:=$1
$NavBtnTxt:=$2

OBJECT SET ENABLED:C1123(*; "navBtn_@"; False:C215)
OBJECT SET VISIBLE:C603(*; "actBtn_@"; True:C214)

Case of 
	: ($NavBtnTxt="Save")
		
		Case of 
			: ($referer="Person")
				Form:C1466.mainSubform.person.save()
				
			: ($referer="Company")
				Form:C1466.mainSubform.company.save()
				
			: ($referer="Donations")
				Form:C1466.mainSubform.donation.save()
				
			: ($referer="Events")
				Form:C1466.mainSubform.event.save()
				
			: ($referer="Merchandise")
				Form:C1466.mainSubform.merch.save()
				
			: ($referer="Order")
				Form:C1466.mainSubform.order.save()
				
		End case 
		VALIDATE TRANSACTION:C240
		
	: ($NavBtnTxt="Cancel")
		REJECT:C38
		CANCEL TRANSACTION:C241
End case 
vtNavBtnTxt:=""
If (vt_ActBtOrig#"")
	vtActiveBt:=vt_ActBtOrig
	vt_ActBtOrig:=""
End if 

ObjForm_SubformLoad(vtActiveBt)
OBJECT SET VISIBLE:C603(*; "actBtn_@"; False:C215)