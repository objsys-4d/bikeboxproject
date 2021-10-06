//%attributes = {"shared":true}
C_OBJECT:C1216($oMember)  // COURSE RECORD

// GET THE (PHYSICAL) COURSE RECORD FROM THE DATASTORE

$oMember:=ds:C1482.Member.get(oConnection.data.Member.UUID)

// NEW RECORD TO BE SAVED FROM DATA?

If ($oMember=Null:C1517)
	
	$oMember:=ds:C1482.Member.new()
	
End if 

$oMember.lastName:=oConnection.data.Member.lastName
$oMember.firstName:=oConnection.data.Member.firstName
$oMember.birthday:=Date:C102(oConnection.data.Member.birthday)
$oMember.phone:=oConnection.data.Member.phone
$oMember.email:=oConnection.data.Member.email
$oMember.address:=oConnection.data.Member.address
$oMember.city:=oConnection.data.Member.city
$oMember.state:=oConnection.data.Member.state
$oMember.zip:=oConnection.data.Member.zip
$oMember.membershipType:=oConnection.data.Member.membershipType
$oMember.memberSince:=oConnection.data.Member.memberSince

$oMember.save()

// RETURN TO THE REFERER...

Case of 
	: (oConnection.referer="members")
		
		oConnection.form:="members-list.html"
		oConnection.action:="index"
		
End case 
