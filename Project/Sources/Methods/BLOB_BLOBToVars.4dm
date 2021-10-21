//%attributes = {}
// RETRIEVE VARIABLES FROM BLOB project method 
// RETRIEVE VARIABLES FROM BLOB ( Pointer { ; Pointer ... { ; Pointer } } ) 
// RETRIEVE VARIABLES FROM BLOB ( BLOB { ; Var1 ... { ; Var2 } } )
C_POINTER:C301(${1})
C_LONGINT:C283($vlParam; $vlOffset)
$vlOffset:=0

For ($vlParam; 2; Count parameters:C259)
	BLOB TO VARIABLE:C533($1->; ${$vlParam}->; $vlOffset)
End for 