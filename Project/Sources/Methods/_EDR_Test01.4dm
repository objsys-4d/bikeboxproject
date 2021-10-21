//%attributes = {}
TRACE:C157

C_TEXT:C284($fullName; $firstName; $lastName)
C_OBJECT:C1216($oPersonSelection)
$oPersonSelection:=ds:C1482.Person.all()
For each ($oPerson; $oPersonSelection)
	$fullName:=UTIL_ProperCase($oPerson.fullName)
	If (Position:C15(","; $fullName)=0)
		If (Position:C15(" "; $fullName)=0)
			$firstName:=$fullName
			$lastName:=""
		Else 
			$firstName:=Substring:C12($fullName; 1; Position:C15(" "; $fullName)-1)
			$lastName:=Substring:C12($fullName; Position:C15(" "; $fullName)+1)
		End if 
	Else 
		$firstName:=Substring:C12($fullName; Position:C15(","; $fullName)+2)
		$lastName:=Substring:C12($fullName; 1; Position:C15(","; $fullName)-1)
	End if 
	
	$oPerson.firstName:=$firstName
	$oPerson.lastName:=$lastName
	$oPerson.fullName:=$firstName+" "+$lastName
	$oPerson.save()
	
End for each 

If (False:C215)
	C_OBJECT:C1216($oPersonSelection)
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
End if 



