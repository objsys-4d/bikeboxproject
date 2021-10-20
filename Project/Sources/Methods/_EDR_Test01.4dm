//%attributes = {}
TRACE:C157


oPersonSelection:=New object:C1471
$oPersonSelection:=ds:C1482.Person.all()
For each ($oPerson; $oPersonSelection)
	
	If ($oPerson.personObject=Null:C1517)
		$oPerson.personObject:=New object:C1471
		$oPerson.personObject.active:="No"
		$oPerson.personObject.valid:="No"
		$oPerson.personObject.status:="Review"
		
		//$result:=ds.Person.query("fullName = :1"; $name)
		//If ($result.length=0)
		$oPerson.personObject.duplicateName:="No"
		//Else 
		//$oPerson.personObject.duplicateName:="Yes"
		//End if 
		$oPerson.save()
		
	Else 
		$active:=$oPerson.personObject.active
		$valid:=$oPerson.personObject.valid
		$status:=$oPerson.personObject.status
		$duplicateName:=$oPerson.personObject.duplicateName
	End if 
	
End for each 




