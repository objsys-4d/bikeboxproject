Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284(vtNavBtnTxt; vt_InputTitle; vtcompanyName; vlPersonUUID)
		OBJECT SET ENABLED:C1123(*; "bttnDel_Donation"; False:C215)
		OBJECT SET ENABLED:C1123(*; "bttnDel_Event"; False:C215)
		C_OBJECT:C1216($oComp; vtdataClass; vtdataStore)
		
		Case of 
			: (vtNavBtnTxt="Add")
				vtcompanyName:=""
				vt_InputTitle:="Add New Person Record"
				Form:C1466.person:=ds:C1482.Person.new()
				vlPersonUUID:=Form:C1466.person.UUID
				
			: (vtNavBtnTxt="Edit")
				vt_InputTitle:="Person Record"
				$oComp:=ds:C1482.Person.query("UUID = :1"; vlPersonUUID)
				Form:C1466.person:=$oComp[0]
				vtcompanyName:=Form:C1466.person.Person_Company.companyName
				
		End case 
		
		//donations
		Form:C1466.data_list:=$oComp.Person_Donation
		Output_lbInit("donationlb")
		
		//participants
		Form:C1466.data_list:=$oComp.Person_Participant
		Output_lbInit("participantlb")
		
End case 