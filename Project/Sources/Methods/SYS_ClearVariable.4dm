//%attributes = {}
  // ----------------------------------------------------
  // User name (OS): edu.reyes
  // Programmer: EDRJr.
  // Date and time: 06/04/08, 10:03:23
  // ----------------------------------------------------
  // Method: SYS_ClearVariable
  // Description
  // 
  // www.4dtoday.com
  //Replacing 4D's CLEAR VARIABLE Command
  //Submitted by Tom Dillon, DataCraft
  //
  //4D's CLEAR VARIABLE command acts very differently between compiled and interpreted
  //databases and should be used carefully, if at all, with that in mind. In an interpreted
  //database, the variable is cleared entirely from memory. It becomes undefined. This is not
  //the case in a compiled database. If you're interested in having your compiled and interpreted
  //(i.e. development version) databases act the same then you may want to avoid the CLEAR VARIABLE
  //command.
  //
  // Parameters
  // $1 - Pointer to the variable to be cleared
  // ----------------------------------------------------
C_POINTER:C301($VarPtr;$1)
C_LONGINT:C283($Type)

$VarPtr:=$1
$Type:=Type:C295($VarPtr->)

Case of 
	: (($Type=Is text:K8:3) | ($Type=Is string var:K8:2))
		$VarPtr->:=""
		
	: ($Type=Array 2D:K8:24)
		DELETE FROM ARRAY:C228($VarPtr->;1;Size of array:C274($VarPtr->))
		
		  //: (($Type=String array ) | ($Type=Text array ))
		  //$Size:=Size of array($VarPtr->)
		  //For ($i;1;$Size)
		  //$VarPtr->{$i}:=""
		  //End for 
		  //DELETE FROM ARRAY($VarPtr->;1;$Size)
		
	: (($Type=Boolean array:K8:21) | ($Type=Date array:K8:20) | ($Type=Integer array:K8:18) | ($Type=LongInt array:K8:19) | ($Type=Picture array:K8:22) | ($Type=Pointer array:K8:23) | ($Type=Real array:K8:17) | ($Type=String array:K8:15) | ($Type=Text array:K8:16))
		$Size:=Size of array:C274($VarPtr->)
		If ($Size>0)
			DELETE FROM ARRAY:C228($VarPtr->;1;$Size)
		End if 
		
	: ($Type=Is boolean:K8:9)
		$VarPtr->:=False:C215
		
	: ($Type=Is date:K8:7)
		$VarPtr->:=!00-00-00!
		
	: ($Type=Is time:K8:8)
		$VarPtr->:=?00:00:00?
		
	: (($Type=Is integer:K8:5) | ($Type=Is longint:K8:6) | ($Type=Is real:K8:4))
		$VarPtr->:=0
		
	: ($Type=Is pointer:K8:14)
		ARRAY POINTER:C280($aPtr;0)
		$VarPtr->:=$aPtr{0}
		
	: ($Type=Is BLOB:K8:12)
		SET BLOB SIZE:C606($VarPtr->;0)
		
	: ($Type=Is picture:K8:10)
		$VarPtr->:=0*$VarPtr->
		
	: ($Type=Is object:K8:27)
		$VarPtr->:=Null:C1517
End case 