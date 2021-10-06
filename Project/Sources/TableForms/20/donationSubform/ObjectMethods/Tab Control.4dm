
//reset page elements
Form:C1466.donationlb:=Null:C1517
vrTotalAmt:=0
vlPartCount:=0
Form:C1466.personOutput_lb.text:=""
Form:C1466.eventOutput_lb.text:=""
vbLoadFlag:=True:C214

Case of 
	: (tbDonationsTab{tbDonationsTab}="PERSON")
		vtTabName:=""
		Form:C1466.personOutput_lb.data:=ds:C1482.Person.all()
		FORM GOTO PAGE:C247(1; *)
		
	: (tbDonationsTab{tbDonationsTab}="EVENT")
		vtTabName:=""
		Form:C1466.eventOutput_lb.data:=ds:C1482.Event.all()
		FORM GOTO PAGE:C247(2; *)
		
End case 