
CONFIRM:C162("Are you sure you want to delete this donation record?"; "Yes"; "No")
If (OK=1)
	//C_LONGINT($CollPos)
	
	objDeleteListboxElement("donationlb")
	
	//$dataClass:=Form.donationlb.getDataClass()
	
	//$dataClass:=vDSTest.getDataClass()
	//$dataStore:=vDSTest.getDataClass().getDataStore()
	
	//$CollPos:=Form.donationlb.curPos-1
	//$oEntitySel:=Form.donationlb.data
	//$UUID:=Form.donationlb.data[$CollPos].UUID
	//$oSel:=$oEntitySel.get($UUID)  //ds.Donation.get($UUID)
	//$oSel.drop()
	
	
	//refresh listbox data
	$oPerson:=ds:C1482.Person.get(vlPersonUUID)
	Form:C1466.data_list:=$oPerson.Person_Donation
	Output_lbInit("donationlb")
	
	OBJECT SET ENABLED:C1123(*; "bttnDel_Donation"; False:C215)
End if 