//%attributes = {"shared":true}
C_OBJECT:C1216($oNotification)  // NOTIFICATION

// NOTIFY USER OF THE SENT EMAIL...

$oNotification:=New object:C1471

$oNotification.type:="success"

$oNotification.icon:="fas fa-envelope text-white"

$oNotification.description:=Ltg_Str_Escape(Ltg_Str_Localise("%message_success")+"<br/>"+oConnection.data.Order.Email)

Notification_New($oNotification)