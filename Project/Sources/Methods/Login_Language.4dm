//%attributes = {"shared":true}
C_TEXT:C284($1)  // LANGUAGE CODE

Ltg_JS_Send ("ltgObj('welcome').html('"+User_Localise ("%welcome";$1)+"')")

Ltg_JS_Send ("ltgObj('.userName').attr('placeholder','"+User_Localise ("%user_name";$1)+"')")

Ltg_JS_Send ("ltgObj('.userPassword').attr('placeholder','"+User_Localise ("%password";$1)+"')")

Ltg_JS_Send ("ltgObj('login').html('"+User_Localise ("%login";$1)+"')")

Ltg_JS_Send ("ltgObjFocus('.userName')")
