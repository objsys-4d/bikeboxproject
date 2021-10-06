//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/24/21, 17:11:55
// ----------------------------------------------------
// Method: Donation_DetailMod
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($oDonation)  // VOUChER RECORD
C_TEXT:C284($txtDon_ID)
C_BOOLEAN:C305($proceed)

$txtDon_ID:=Ltg_URL_GetParam("donation")
//$personID:=oConnection.data.Person.UUID
//$oPerson:=ds.Person.get(oConnection.data.Person.UUID)
//$oPersonDonation:=$oPerson.Person_Donation
Case of 
		
	: (oConnection.action="edit")
		$oDonation:=ds:C1482.Donation.get(oConnection.record)
		$proceed:=True:C214
		
	: (oConnection.action="new")
		
		$oDonation:=New object:C1471
		$proceed:=True:C214
		
End case 


If ($proceed)
	
	oConnection.data.userLanguage:=oConnection.session.userLanguage  // DATEPICKER LOCALE
	oConnection.data.Donation:=$oDonation  // VOUCHER
	$person:=oConnection.data.Person.lastName+", "+oConnection.data.Person.firstName
	Ltg_JS_Send("ltgObj('Donation.person').val('"+$person+"')")
	Ltg_JS_Send("ltgObj('Donation.personID').val('"+String:C10(oConnection.data.Person.personID)+"')")
	Event_objPulldown(oConnection.data.Donation.eventID; False:C215)
	
End if 
