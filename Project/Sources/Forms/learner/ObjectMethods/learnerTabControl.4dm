
// ----------------------------------------------------
// User name (OS): Mike Beatty
// Date and time: 08/17/21, 12:37:06
// ----------------------------------------------------
// Method: learner.learnerTabControl
// Description
// 
//
// Parameters
//
// Change History
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		
		
		Case of 
				
			: (learnerTabControl=1)
				OBJECT SET VISIBLE:C603(*;"courseSubform";True:C214)
				OBJECT SET VISIBLE:C603(*;"voucherSubform";False:C215)
				//OBJECT SET SUBFORM(*;"learnerTabSubform";"courseSubform")
				//OBJECT SET SUBFORM(*;"mainSubform";"learner")
				
			: (learnerTabControl=2)
				OBJECT SET VISIBLE:C603(*;"courseSubform";False:C215)
				OBJECT SET VISIBLE:C603(*;"voucherSubform";True:C214)
				//OBJECT SET SUBFORM(*;"learnerTabSubform";"voucherSubform")
				
			: (learnerTabControl=3)
				OBJECT SET VISIBLE:C603(*;"courseSubform";False:C215)
				OBJECT SET VISIBLE:C603(*;"voucherSubform";True:C214)
				//OBJECT SET SUBFORM(*;"learnerTabSubform";"voucherSubform")
			Else 
				
		End case 
		
		
	Else 
		
End case 