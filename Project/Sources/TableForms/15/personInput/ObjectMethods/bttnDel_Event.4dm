
CONFIRM:C162("Are you sure you want to delete this participant record?"; "Yes"; "No")
If (OK=1)
	//$oSel:=curItem
	//$oSel.drop()
	//Form.participantlb:=Form.person.Person_Participant
	
	objDeleteListboxElement("participantlb")
	
	//refresh listbox data
	$oPart:=ds:C1482.Person.get(vlPersonUUID)
	Form:C1466.data_list:=$oPart.Person_Participant
	Output_lbInit("participantlb")
	
	OBJECT SET ENABLED:C1123(*; "bttnDel_Event"; False:C215)
End if 