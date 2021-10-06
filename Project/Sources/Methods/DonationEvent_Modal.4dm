//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 00:06:17
// ----------------------------------------------------
// Method: DonationPerson_Modal
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($oEventRec)
C_LONGINT:C283($eventID)


Case of 
	: (oConnection.data.Donation.event="0")
		//should just close the modal or not call the modal
		$oEventRec:=ds:C1482.Event.all()
		
		
	: (oConnection.data.Donation.event="-1")
		//new record
		$oEventRec:=New object:C1471
		
	Else 
		$eventID:=Num:C11(oConnection.data.Donation.event)
		$oEventRec:=ds:C1482.Event.query("eventID = :1"; $eventID)
		//oConnection.data.Company:=$oCompanyRec  //[0]  <--- we ommit [0] for the dialog to not display.
		
End case 
oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE
oConnection.data.Event:=$oEventRec
