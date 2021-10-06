//%attributes = {}
C_LONGINT:C283($nError)

  // INITIALISE ERROR CODE

$nError:=0

Case of 
		
	: (oConnection.responseType="json")
		
		If (oConnection.action="method")
			
			  // UPDATE CLIENT JSON
			
			Ltg_Method_Execute (oConnection.method)
		End if 
		
	: (oConnection.responseType="html")
		
		Case of 
				
			: (oConnection.action="file")
				
				Ltg_Method_Execute (oConnection.method)
				
			: (oConnection.action="method")
				
				Ltg_Method_Execute (oConnection.method)
				
				  // UPDATE CLIENT JS
				
				Ltg_Conn_Update 
				
				oConnection.responseType:="javascript"
				
			Else 
				
				If (oConnection.method#"")
					
					Ltg_Method_Execute (oConnection.method)
					
					  // JAVASCRIPT ONLY?
					
					If (oConnection.responseType="javascript")
						
						  // UPDATE CLIENT JS
						
						Ltg_Conn_Update 
						
					End if 
				End if 
				
				  // PUBLISH FORM?
				
				If (oConnection.responseType="html")
					
					  // PUBLISH CONTENT FORM
					
					$nError:=Ltg_Conn_PublishForm (oConnection.form)
					
					  // PUBLISH CONTAINER FORM (E.G. INDEX.HTML)?
					
					If (oConnection.formContainer#"")
						
						$nError:=Ltg_Conn_PublishForm (oConnection.formContainer)
						
					End if 
				End if 
				
		End case 
		
		  // SET THE PAYLOAD TYPE FOR THE CLIENT
		
		Ltg_HTTP_SetHeader ("VND.Lightning.Payload";oConnection.responseType)
End case 

  // DEBUG CONNECTION

  // TRACE