
CONFIRM:C162("Are you sure you want to delete this participant record?"; "Yes"; "No")
If (OK=1)
	
	objDeleteListboxElement("participantlb")
	
	
	//refresh list data
	$oPartList:=ds:C1482.Event.get(vlEventUUID)
	Form:C1466.data_list:=$oPartList.Event_Participant
	Output_lbInit("participantlb")
	
	//recalculate sum
	Form:C1466.event.totalDonation:=Form:C1466.participantlb.data.sum("amountDonated")
	OBJECT SET ENABLED:C1123(*; "bttnDel_Part"; False:C215)
End if 