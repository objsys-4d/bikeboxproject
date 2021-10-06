//%attributes = {}
// ----------------------------------------------------
// User name (OS): EDR
// Date and time: 01/07/10, 21:07:26
// ----------------------------------------------------
// Method: GEN_Date_Get_Month_LastDate
// Description
//  this method returns the last date of the month
// pass any date of the month you want to get the last date of
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1; $0; $Date)

$Date:=$1

$0:=(Add to date:C393(GEN_Date_Get_Month_FirstDate($Date); 0; 1; 0))-1
