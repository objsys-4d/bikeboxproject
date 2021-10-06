Case of 
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Selection Change:K2:29)
		If (vbLoadFlag)  //so this action is only called once (because of On Selection Change)
			
			vbLoadFlag:=False:C215
			vSelPosn:=Form:C1466.personOutput_lb.curPos
			//CALL SUBFORM CONTAINER(On Load)
			C_OBJECT:C1216($oDonation)
			
			If (Form:C1466.personOutput_lb.curPos=0)
				Form:C1466.person:=Null:C1517
				Form:C1466.donationlb:=Null:C1517
				vrTotalAmt:=0
			Else 
				vlPersonID:=Form:C1466.personOutput_lb.curItem.personID
				Form:C1466.person:=Form:C1466.personOutput_lb.curItem
				If (Form:C1466.personOutput_lb.curItem.Person_Donation.length=0)
					Form:C1466.donationlb:=Null:C1517
					vrTotalAmt:=0
				Else 
					$oDonation:=Form:C1466.personOutput_lb.curItem.Person_Donation
					Form:C1466.donationlb:=$oDonation
					vrTotalAmt:=$oDonation.sum("amount")
				End if 
			End if 
			
		Else 
			vbLoadFlag:=True:C214
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		vb_OutPerson:=True:C214
		CALL SUBFORM CONTAINER:C1086(On Validate:K2:3)
		
End case 
