//%attributes = {"shared":true}
If (oConnection.url="/LTGAJAX")
	
	  // CLEAN UP INDEX.HTML TO DISPLAY LOGIN FORM IN CURRENT CONTENT...
	
	Ltg_JS_Send ("ltgQCHide()")  // HIDE QUALITY CONTROL
	
	Ltg_JS_Send ("$('body').addClass('bg-gradient-primary')")
	
	Ltg_JS_Send ("ltgObj('content-wrapper').addClass('bg-gradient-primary')")
	
	Ltg_JS_Send ("ltgObj('accordionSidebar').css('display','none')")
	Ltg_JS_Send ("ltgObj('topbar').css('display','none')")
End if 

  // USER INFORMATION MESSAGE

oConnection.data.userInfo:="Your session has expired."

  // CLOSE THE SESSION

Ltg_Session_Close (oConnection.session.LTGSID)
