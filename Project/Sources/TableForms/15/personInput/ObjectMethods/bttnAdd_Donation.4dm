GEN_Dlg_CenterWindow(->[Donation:20]; "donationAdd"; "Person -> Add Donation")
If (OK=1)
	C_OBJECT:C1216($oPerson)
	
	Form:C1466.person.save()
	
	C_OBJECT:C1216($oDonation; $oPerson)
	$oDonation:=ds:C1482.Donation.new()
	$oDonation.amount:=vrAmount
	$oDonation.dateDonation:=vdDonationDate
	$oDonation.personID:=Form:C1466.person.personID
	$oDonation.save()
	
	//refresh listbox data
	$oPerson:=ds:C1482.Person.get(vlPersonUUID)
	Form:C1466.data_list:=$oPerson.Person_Donation
	Output_lbInit("donationlb")
	
End if 