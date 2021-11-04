//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/25/21, 00:52:50
// ----------------------------------------------------
// Method: DonationPerson_Cancel
// Description
// 
//
// Parameters
// ----------------------------------------------------



oConnection.data.Donation.person:="0"
oConnection.data.Donation.personID:=0

oConnection.form:="donationdetail.html"
oConnection.action:="index"

oConnection.responseType:="javascript"
