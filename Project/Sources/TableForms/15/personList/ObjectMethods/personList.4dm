Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		vSelID:=Form:C1466.curItem.personID
		vSelCoID:=Form:C1466.curItem.companyID
		vSelName:=Form:C1466.curItem.lastName+", "+Form:C1466.curItem.firstName
		vSelPhone:=Form:C1466.curItem.phone
		vSelEmail:=Form:C1466.curItem.email
		vSelAddr1:=Form:C1466.curItem.address1
		vSelCity:=Form:C1466.curItem.city
		vSelState:=Form:C1466.curItem.state
		vSelZip:=Form:C1466.curItem.postalCode
		ACCEPT:C269
End case 