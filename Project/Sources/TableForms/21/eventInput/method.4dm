Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle; vlEventUUID)
		OBJECT SET ENABLED:C1123(*; "bttnDel_Part"; False:C215)
		C_OBJECT:C1216($oEvtLB; $oEvent)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vt_InputTitle:="Add New Event"
				Form:C1466.event:=ds:C1482.Event.new()
				vlEventUUID:=Form:C1466.event.UUID
				
			: (vtNavBtnTxt="Edit")
				vt_InputTitle:="Event Record"
				$oEvent:=ds:C1482.Event.query("UUID = :1"; vlEventUUID)
				Form:C1466.event:=$oEvent[0]
				//Form.participantlb:=$oEvent.Event_Participant
				
		End case 
		
		Form:C1466.data_list:=$oEvent.Event_Participant
		Output_lbInit("participantlb")
		
		
End case 