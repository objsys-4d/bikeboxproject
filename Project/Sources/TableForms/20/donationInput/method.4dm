Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle; vlEventUUID; vtdonorName)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vt_InputTitle:="Add New Donation"
				Form:C1466.donation:=ds:C1482.Donation.new()
				vtdonorName:=""
				
			: (vtNavBtnTxt="Edit")
				C_OBJECT:C1216($oDonation)
				vt_InputTitle:="Donation Record"
				$oDonation:=ds:C1482.Donation.query("UUID = :1"; vlDonationUUID)
				Form:C1466.donation:=$oDonation[0]
				vtdonorName:=Form:C1466.donation.Donation_Person.lastName+", "+Form:C1466.donation.Donation_Person.firstName
				vtEventName:=Form:C1466.donation.Donation_Event.eventName
				
		End case 
		
End case 