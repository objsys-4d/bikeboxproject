//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 09/22/21, 20:33:33
// ----------------------------------------------------
// Method: WebLtg_Email
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($recipients; $subject; $message)
$recipients:=oConnection.data.Email.recipients
$subject:=oConnection.data.Email.subject
$message:=oConnection.data.Email.message

Case of 
	: (oConnection.referer="person")
		$personID:=oConnection.data.Person.UUID
		If ($recipients#oConnection.data.Person.email)
			oConnection.data.Person.email:=$recipients
		End if 
		
	: (oConnection.referer="company")
		$companyID:=oConnection.data.Company.UUID
		If ($recipients#oConnection.data.Company.email)
			oConnection.data.Company.email:=$recipients
		End if 
		
	: (oConnection.referer="order")
		$companyID:=oConnection.data.Order.UUID
		If ($recipients#oConnection.data.Order.email)
			oConnection.data.Order.email:=$recipients
		End if 
		
End case 

//*** email ***
C_LONGINT:C283($ProcID; $err)
vbTest:=False:C215  //True
//send email
//$recipients:="edureyesjr@objectivesystems.com, mikebeatty@objectivesystems.com"  //override for now

$ProcID:=New process:C317("Email_Send"; 0; "Send Email"; $recipients; $subject; $message)
//$err:=Email_Send($recipients; $subject; $message)

//create email record
If ($err=0)
	//CREATE RECORD([email])
	//[email]learnerID:=$learnerID
	//[email]date_created:=Current date
	//[email]date_sent:=Current date
	//[email]sender:="developer@objectivesystems.com"
	//[email]recipients:=$recipients
	//[email]subject:=$subject
	//[email]message:=$message
	//SAVE RECORD([email])
	//UNLOAD RECORD([email])
End if 

//perhaps control $err here to control "success"
C_OBJECT:C1216($oNotification)  // NOTIFICATION

// NOTIFY USER OF THE SENT email...
$oNotification:=New object:C1471

$oNotification.type:="success"
$oNotification.icon:="fas fa-envelope text-white"

$oNotification.description:=Ltg_Str_Escape(Ltg_Str_Localise("%message_success")+"<br/>"+$recipients)


//*** email ***
Notification_New($oNotification)



