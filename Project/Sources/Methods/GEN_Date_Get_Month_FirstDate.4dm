//%attributes = {}
// ----------------------------------------------------
// User name (OS): EDR
// Date and time: 01/07/10, 21:07:26
// ----------------------------------------------------
// Method: GEN_Date_Get_Month_FirstDate
// Description
//  this method returns the first date of the month
// pass any date of the month you want to get the first date of
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1; $0; $date)

If (Count parameters:C259=0)
	$date:=Current date:C33(*)
	
Else 
	$date:=$1
	If ($date=!00-00-00!)
		$date:=Current date:C33(*)
	End if 
	
End if 
//dmy format or mdy format
//$strDate:=String(!2019-11-30!;Internal date short)
//$monthTest:=Num(Substring($strDate;1;2))

$ISOdate:=String:C10($date; ISO date:K1:8)

$0:=Date:C102(Substring:C12($ISOdate; 1; 7)+"-01T00:00:00")


