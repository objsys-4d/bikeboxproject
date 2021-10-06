
// ----------------------------------------------------
// User name (OS): Mike Beatty
// Date and time: 08/16/21, 20:52:58
// ----------------------------------------------------
// Method: learner
// Description
// 
//
// Parameters
//
// Change History
// ----------------------------------------------------

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(learnerTabControl;0)
		APPEND TO ARRAY:C911(learnerTabControl;"Course")
		APPEND TO ARRAY:C911(learnerTabControl;"Voucher")
		APPEND TO ARRAY:C911(learnerTabControl;"Payment")
		
		learnerOutput_lb("Init")
		
		Form:C1466.learner_data:=ds:C1482.Learner.all()
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		
		
		
		
	Else 
		
End case 