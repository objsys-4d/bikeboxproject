//%attributes = {}
C_LONGINT:C283($nError)

If (Ltg_Started )
	
	  // SAVE THE USERS COLLECTION SO THAT IT CAN BE PERSISTED
	  // ON THE NEXT STARTUP AS USER PREFERENCES (REFER TO "Web_Startup")
	
	Users_Set 
	
	$nError:=Ltg_Shutdown 
End if 