//%attributes = {"shared":true}
C_OBJECT:C1216($oDonation)  // COMPANY RECORD

// GET THE (PHYSICAL) COMPANY RECORD FROM THE DATASTORE

$oDonation:=ds:C1482.Donation.get(oConnection.data.Donation.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oDonation=Null:C1517)
	
	$oDonation:=ds:C1482.Donation.new()
	
End if 

$oDonation.dateDonation:=Date:C102(oConnection.data.Donation.dateDonation)
If (Num:C11(oConnection.data.Donation.personID)#0)  //0 value will be coming from modal dialog, we don't want this because it will change the value and it shouldn't
	$oDonation.personID:=oConnection.data.Donation.personID
End if 
$oDonation.eventID:=oConnection.data.Donation.event
$oDonation.amount:=oConnection.data.Donation.amount
$oDonation.save()

// RETURN TO THE REFERER...

Case of 
		
	: (oConnection.referer="donation")
		
		oConnection.form:="donationlist.html"
		oConnection.action:="index"
		
	: (oConnection.referer="person")
		
		oConnection.form:="persondetail.html"
		oConnection.action:="index"
		
		DonationInclude_DataTable
		oConnection.responseType:="javascript"
		
		
		//: (oConnection.referer="contacts")
		
		//oConnection.form:="contacts-list.html"
		//oConnection.action:="index"
		
		//: (oConnection.referer="orders")
		
		//oConnection.form:="orders-list.html"
		//oConnection.action:="index"
End case 
