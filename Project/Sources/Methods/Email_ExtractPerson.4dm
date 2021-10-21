//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/20/21, 18:22:45
// ----------------------------------------------------
// Method: Email_ExtractPerson
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_COLLECTION:C1488($1; $EmailCollection)
C_TEXT:C284($name; $email)
C_LONGINT:C283($i; $startPos)
$EmailCollection:=$1

For ($i; 0; $EmailCollection.length-1)
	//get name
	$name:=UTIL_DropSpaces(Substring:C12($EmailCollection[$i]; 1; Position:C15("<"; $EmailCollection[$i])-1))
	If ($name="")  //if no name on email, get the email user name
		$name:=Replace string:C233($EmailCollection[$i]; "<"; "")
		$name:=UTIL_DropSpaces(Replace string:C233($name; ">"; ""))
		$name:=Substring:C12($name; 1; Position:C15("@"; $name)-1)
	End if 
	
	If ($name#"")  //if name not blank, lookup Person table. if name is still blank, skip.
		
		//get email
		$email:=Substring:C12($EmailCollection[$i]; Position:C15("<"; $EmailCollection[$i]))
		$email:=Replace string:C233($email; "<"; "")
		$email:=UTIL_DropSpaces(Replace string:C233($email; ">"; ""))
		
		$oPerson:=New object:C1471
		$oPerson:=ds:C1482.Person.query("email = :1"; $email)
		
		If ($oPerson.length=0)
			$oNewPerson:=ds:C1482.Person.new()
			$oNewPerson.fullName:=$name
			$oNewPerson.email:=$email
			
			$oNewPerson.personObject:=New object:C1471
			$oNewPerson.personObject.active:="No"
			$oNewPerson.personObject.valid:="No"
			$oNewPerson.personObject.status:="Review"
			
			$result:=ds:C1482.Person.query("fullName = :1"; $name)
			If ($result.length=0)
				$oNewPerson.personObject.duplicateName:="No"
			Else 
				$oNewPerson.personObject.duplicateName:="Yes"
			End if 
			
			$oNewPerson.save()
		End if 
		
	End if   //$name#""
	
End for 