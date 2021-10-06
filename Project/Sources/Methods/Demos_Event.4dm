//%attributes = {"shared":true}
C_TEXT:C284($1)  // EVENT

Case of 
	: ($1="onchange")
		
		oConnection.data.demosResult:=$1+" result at "+String:C10(Current time:C178;HH MM SS:K7:1)+" = "+oConnection.data.demosInput
		
	: ($1="onclick")
		
		oConnection.data.demosInput:=""
		
		oConnection.data.demosResult:=$1+" result at "+String:C10(Current time:C178;HH MM SS:K7:1)
End case 

