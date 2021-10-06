//%attributes = {"shared":true}
C_BLOB:C604($bloDocument)

C_OBJECT:C1216($oDocument)

C_TEXT:C284($txtFolder)

$oDocument:=Ltg_File_Upload (->$bloDocument)

  // SAVE TO "UPLOADS" FOLDER IN THE WEBFOLDER

$txtFolder:=oConnection.webFolder+Folder separator:K24:12+"uploads"+Folder separator:K24:12

BLOB TO DOCUMENT:C526($txtFolder+$oDocument.name;$bloDocument)

  // USING THE "UPPY" PLUGIN?

If (oConnection.url="/demos-uppy")
	
	  // SEND A SUCCESS RESULT
	
	Ltg_HTTP_SendText ("success")
End if 
