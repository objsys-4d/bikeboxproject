//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/24/21, 17:11:55
// ----------------------------------------------------
// Method: Donation_DetailMod
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($oDonation)  // VOUChER RECORD
C_TEXT:C284($txtDon_ID)
C_BOOLEAN:C305($proceed)

Case of 
	: (oConnection.referer="donation")
		$oParticipant:=ds:C1482.Event.get(oConnection.record)  //query("eventID = :1"; Num(oConnection.data.Donation.event))
		$proceed:=True:C214
		
	: (oConnection.referer="person")
		If (oConnection.record="")
			$oParticipant:=New object:C1471
			$oParticipant.personID:=Num:C11(oConnection.data.Person.personID)
			$oParticipant.companyID:=0
			$oParticipant.eventID:=0
			$oParticipant.amountDonated:=0
		Else 
			$oParticipant:=ds:C1482.Participant.get(oConnection.record)
		End if 
		$proceed:=True:C214
		
	: (oConnection.referer="company")
		
		If (oConnection.record="")
			$oParticipant:=New object:C1471
			$oParticipant.personID:=0
			$oParticipant.companyID:=Num:C11(oConnection.data.Company.companyID)
			$oParticipant.eventID:=0
			$oParticipant.amountDonated:=0
		Else 
			$oParticipant:=ds:C1482.Participant.get(oConnection.record)
		End if 
		$proceed:=True:C214
		
	: (oConnection.referer="event")
		If (oConnection.record="")
			$oParticipant:=New object:C1471
			$oParticipant.personID:=0
			$oParticipant.companyID:=0
			$oParticipant.eventID:=Num:C11(oConnection.data.Event.eventID)
			$oParticipant.amountDonated:=0
		Else 
			$oParticipant:=ds:C1482.Participant.get(oConnection.record)
		End if 
		$proceed:=True:C214
		
End case 

C_TEXT:C284($person; $eventDate; $amountStr; $company)
If ($proceed)
	oConnection.data.Participant:=$oParticipant  // PARTICIPANT
	
	Event_objPulldown($oParticipant.eventID; False:C215)
	
	Case of 
		: (oConnection.referer="company")
			If ($oParticipant.companyID#0)
				$company:=oConnection.data.Company.companyName
				Ltg_JS_Send("ltgObj('Participant.personName').val('"+$company+"')")
			End if 
			If ($oParticipant.eventID#0)
				$eventDate:=String:C10($oParticipant.Participant_Event.dateEvent)
				Ltg_JS_Send("ltgObj('Participant.date').val('"+$eventDate+"')")
			End if 
			
			$amountStr:=String:C10($oParticipant.amountDonated; "$###,###,##0.00")
			Ltg_JS_Send("ltgObj('Participant.amount').val('"+$amountStr+"')")
			
			
		: (oConnection.referer="person")
			If ($oParticipant.personID#0)
				$person:=oConnection.data.Person.lastName+", "+oConnection.data.Person.firstName  //$oParticipant.Participant_Person.lastName+", "+$oParticipant.Participant_Person.firstName
				Ltg_JS_Send("ltgObj('Participant.personName').val('"+$person+"')")
			End if 
			If ($oParticipant.eventID#0)
				$eventDate:=String:C10($oParticipant.Participant_Event.dateEvent)
				Ltg_JS_Send("ltgObj('Participant.date').val('"+$eventDate+"')")
			End if 
			
			$amountStr:=String:C10($oParticipant.amountDonated; "$###,###,##0.00")
			Ltg_JS_Send("ltgObj('Participant.amount').val('"+$amountStr+"')")
			
		: (oConnection.referer="donation")
			Ltg_JS_Send("ltgObj('Participant.personName').val('"+$oParticipant.eventName+"')")
			Ltg_JS_Send("ltgObj('Participant.date').val('"+String:C10($oParticipant.dateEvent)+"')")
			$amountStr:=String:C10($oParticipant.totalDonation; "$###,###,##0.00")
			Ltg_JS_Send("ltgObj('Participant.amount').val('"+$amountStr+"')")
			Ltg_JS_Send("ltgObj('Participant.amount').attr('disabled',true)")
			Ltg_JS_Send("ltgObj('Donation.event').attr('hidden',true)")
			
		: (oConnection.referer="event")
			C_OBJECT:C1216($oPcpPerson)
			If ($oParticipant.eventID#0)
				$eventDate:=String:C10(oConnection.data.Event.dateEvent)
				If ($oParticipant.personID=0)
					Ltg_JS_Send("ltgObj('Participant.personName').attr('hidden',true)")
					Ltg_JS_Send("ltgObj('Participant.personNamepd').attr('hidden',false)")
					Ltg_JS_Send("ltgObj('Participant.date').val('"+$eventDate+"')")
					Ltg_JS_Send("ltgObj('Donation.event').attr('disabled',true)")
					
					//pulldown for person
					//Person Name pulldown
					C_TEXT:C284($personName)
					Ltg_JS_Send("ltgSelectDeleteOptions('Participant.personNamepd')")
					C_OBJECT:C1216($oPer; $oPerson)
					$oPerson:=ds:C1482.Person.all().orderBy("lastName asc")
					For each ($oPer; $oPerson)
						$personName:=$oPer.lastName+", "+$oPer.firstName
						Ltg_JS_Send("ltgSelectAddOption('Participant.personNamepd','"+String:C10($oPer.personID)+"','"+$personName+"')")
					End for each 
					Ltg_JS_Send("ltgSelectSetValue('Participant.personNamepd','"+String:C10($oPsn.personID)+"')")
					
				Else 
					$oPcpPerson:=$oParticipant.Participant_Person
					If ($oPcpPerson=Null:C1517)
						$person:=""
					Else 
						$person:=$oPcpPerson.lastName+", "+$oPcpPerson.firstName
					End if 
					Ltg_JS_Send("ltgObj('Participant.personName').val('"+$person+"')")
					Ltg_JS_Send("ltgObj('Participant.date').val('"+$eventDate+"')")
					Ltg_JS_Send("ltgObj('Donation.event').attr('disabled',true)")
					$amountStr:=String:C10($oParticipant.amountDonated; "$###,###,##0.00")
					Ltg_JS_Send("ltgObj('Participant.amount').val('"+$amountStr+"')")
					
				End if 
				
			End if 
			
			
	End case 
	
	
	
	//$person:=oConnection.data.Person.lastName+", "+oConnection.data.Person.firstName
	//Ltg_JS_Send("ltgObj('Donation.person').val('"+$person+"')")
	//Event_objPulldown(oConnection.data.Donation.eventID; False)
	
End if 
