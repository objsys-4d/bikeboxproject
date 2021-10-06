//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/10/21, 01:34:44
// ----------------------------------------------------
// Method: ObjForm_NavBtn
// Description
// // ----------------------------------------------------
// User name (OS): Edu
// Date and time: 08/31/21, 21:26:38
// ----------------------------------------------------
// Method: ObjForm_NavBtn
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $2; $referer; vtNavBtnTxt)
$referer:=$1
vtNavBtnTxt:=$2

OBJECT SET ENABLED:C1123(*; "navBtn_@"; False:C215)
OBJECT SET VISIBLE:C603(*; "actBtn_@"; True:C214)

Case of 
	: (vtNavBtnTxt="Add")
		START TRANSACTION:C239
		Case of 
			: ($referer="Person")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Person:15]; "personInput")
				
			: ($referer="Company")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Company:16]; "companyInput")
				
			: ($referer="Donations")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Donation:20]; "donationInput")
				
			: ($referer="Events")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Event:21]; "eventInput")
				
			: ($referer="Merchandise")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Merchandise:17]; "merchInput")
				
			: ($referer="Order")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Order:18]; "orderInput")
				
		End case 
		
		
	: (vtNavBtnTxt="Edit")
		START TRANSACTION:C239
		Case of 
			: ($referer="Person")
				EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objPerson_GetID")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Person:15]; "personInput")
				
			: ($referer="Company")
				EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objCompany_GetID")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Company:16]; "companyInput")
				
			: ($referer="Donations")
				//EXECUTE METHOD IN SUBFORM("mainSubform"; "objDonation_GetID")
				//OBJECT SET SUBFORM(*; "mainSubform"; [Donation]; "donationInput")
				
			: ($referer="Events")
				EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objEvent_GetID")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Event:21]; "eventInput")
				
			: ($referer="Merchandise")
				EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objMerch_GetID")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Merchandise:17]; "merchInput")
				
			: ($referer="Order")
				EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objOrder_GetID")
				OBJECT SET SUBFORM:C1138(*; "mainSubform"; [Order:18]; "orderInput")
				
				
		End case 
		
	: (vtNavBtnTxt="Delete")
		CONFIRM:C162("Are you sure you want to delete this record?")
		If (OK=1)
			C_OBJECT:C1216($oSel)
			Case of 
				: ($referer="Person")
					EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objPerson_GetID")
					$oSel:=ds:C1482.Person.query("UUID = :1"; vlPersonUUID)
					
				: ($referer="Company")
					EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objCompany_GetID")
					$oSel:=ds:C1482.Company.query("UUID = :1"; vlCompanyUUID)
					
				: ($referer="Donations")
					//EXECUTE METHOD IN SUBFORM("mainSubform"; "objDonation_GetID")
					//$oSel:=ds.Donation.query("UUID = :1"; vlSupplierID)
					
				: ($referer="Events")
					EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objEvent_GetID")
					$oSel:=ds:C1482.Event.query("UUID = :1"; vlEventUUID)
					
				: ($referer="Merchandise")
					EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objMerch_GetID")
					$oSel:=ds:C1482.Merchandise.query("UUID = :1"; vlMerchUUID)
					
				: ($referer="Orders")
					EXECUTE METHOD IN SUBFORM:C1085("mainSubform"; "objOrder_GetID")
					$oSel:=ds:C1482.Order.query("UUID = :1"; vlOrderUUID)
					
					
			End case 
			$success:=$oSel[0].drop()
			ObjForm_SubformLoad(vtActiveBt)
			OBJECT SET VISIBLE:C603(*; "actBtn_@"; False:C215)
		End if 
		
End case 


//
// Parameters
// ----------------------------------------------------

