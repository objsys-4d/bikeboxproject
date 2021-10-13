//%attributes = {}
//After these methods have been added to your application, you can write:
//System variables and sets
//The OK variable is set to 1 if the variable has been successfully stored, otherw
// STORE VARIABLES INTO BLOB project method ` STORE VARIABLES INTO BLOB ( Pointer { ; Pointer ... { ; Pointer } } ) ` STORE VARIABLES INTO BLOB ( BLOB { ; Var1 ... { ; Var2 } } )
C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)
SET BLOB SIZE:C606($1->; 0)

For ($vlParam; 2; Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->; $1->; *)
End for 