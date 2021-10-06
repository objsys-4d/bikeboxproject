//%attributes = {"shared":true}
C_TEXT:C284($1)

Case of 
	: ($1=".demosFocus1")
		
		oConnection.data.demosFocus1:="#1 has focus at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
		oConnection.data.demosFocus2:=""
		oConnection.data.demosFocus3:=""
		
	: ($1=".demosFocus2")
		
		oConnection.data.demosFocus1:=""
		oConnection.data.demosFocus2:="#2 has focus at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
		oConnection.data.demosFocus3:=""
		
	: ($1=".demosFocus3")
		
		oConnection.data.demosFocus1:=""
		oConnection.data.demosFocus2:=""
		oConnection.data.demosFocus3:="#3 has focus at "+String:C10(Current time:C178(*);HH MM SS:K7:1)
End case 

Ltg_JS_Send ("ltgObjFocus('"+$1+"')")

