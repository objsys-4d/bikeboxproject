//%attributes = {"shared":true}

  // UPDATE DIALOG CONTENT
Ltg_JS_Send ("ltgObj('demo-dialog-content').html('"+"Dialog opened at "+String:C10(Current time:C178;HH MM SS:K7:1)+"')")

  // OPEN DIALOG
Ltg_JS_Send ("ltgDialogOpen('demo-dialog')")