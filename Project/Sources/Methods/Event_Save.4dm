//%attributes = {"shared":true}
C_OBJECT:C1216($oEvent)  // COMPANY RECORD

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oEvent:=ds:C1482.Event.get(oConnection.data.Event.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oEvent=Null:C1517)
	
	$oEvent:=ds:C1482.Event.new()
	
End if 

$oEvent.dateEvent:=Date:C102(oConnection.data.Event.dateEvent)
$oEvent.eventName:=oConnection.data.Event.eventName
$oEvent.recurring:=oConnection.data.Event.recurring
$oEvent.totalDonation:=oConnection.data.Event.totalDonation
$oEvent.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="event")
		
		oConnection.form:="events-list.html"
		oConnection.action:="index"
		
		//: (oConnection.referer="contacts")
	: (oConnection.referer="donation")
		oConnection.data.Donation.event:=String:C10($oEvent.eventID)
		oConnection.data.Donation.eventID:=$oEvent.eventID
		Ltg_JS_Send("ltgSelectAddOption('Donation.event','"+String:C10($oEvent.eventID)+"','"+$oEvent.eventName+"')")
		Ltg_JS_Send("ltgSelectSetValue('Donation.event','"+String:C10($oEvent.eventID)+"')")
		
		oConnection.form:="donations-detail.html"
		oConnection.action:="index"
		
		oConnection.responseType:="javascript"
		
	: (oConnection.referer="person")
		
		oConnection.form:="persondetail.html"
		oConnection.action:="index"
		
		oConnection.responseType:="javascript"
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
