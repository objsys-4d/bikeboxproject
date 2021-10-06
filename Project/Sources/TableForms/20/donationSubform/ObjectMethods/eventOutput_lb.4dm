Case of 
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29)
		If (vbLoadFlag)  //so this action is only called once (because of On Selection Change)
			
			vbLoadFlag:=False:C215
			vSelPosn:=Form:C1466.eventOutput_lb.curPos
			//CALL SUBFORM CONTAINER(On Load)
			
			If (Form:C1466.eventOutput_lb.curPos=0)
				Form:C1466.donationlb:=Null:C1517
				Form:C1466.participantlb:=Null:C1517
			Else 
				Form:C1466.event:=Form:C1466.eventOutput_lb.curItem
				Form:C1466.participantlb:=Form:C1466.event.Event_Participant
				vlPartCount:=Form:C1466.participantlb.length
				
				$oDonation:=Form:C1466.eventOutput_lb.curItem.Event_Donation
				Form:C1466.donationlb:=$oDonation
				vrTotalAmt:=$oDonation.sum("amount")
			End if 
			
			
		Else 
			vbLoadFlag:=True:C214
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		vb_OutCustomer:=True:C214
		CALL SUBFORM CONTAINER:C1086(On Validate:K2:3)
		
End case 
