C_OBJECT:C1216($oMailAttach)
$oMailInfo:=New object:C1471
$oMailInfo.recipient:=""
$oMailInfo.cc:=vtMail_CC
$oMailInfo.subject:=vtMail_Subject
$oMailInfo.type:="forward"
$oMailInfo.message:=vtMail_Body
$oMailInfo.bodyType:=vtMail_BodyType


If (Size of array:C274(pdAttachments)=0)
	emailSendStartProcess($oMailInfo)
Else 
	C_BLOB:C604($BlobContainter)
	ARRAY BLOB:C1222($arAttachBLOB; 0)
	ARRAY TEXT:C222($arAttachBLOBfileName; 0)
	$eMaildata:=Form:C1466.receiveMails_lb.curItem.attachments
	$loop:=$eMaildata.length-1
	
	$eMailColl:=New collection:C1472
	For each ($loop; $eMaildata)
		$content:=$loop.getContent()  //$eMaildata[$a].getContent()
		APPEND TO ARRAY:C911($arAttachBLOB; $content)
		APPEND TO ARRAY:C911($arAttachBLOBfileName; $loop.name)
		//$BlobText:=BLOB to text($content; UTF8 text without length)
		//$eMailColl.push(New collection($BlobText; $loop.name))
	End for each 
	
	BLOB_VarsToBLOB(->$BlobContainter; ->$arAttachBLOB; ->$arAttachBLOBfileName)
	//For ($a; 0; $loop)
	////APPEND TO ARRAY($arAttachBLOB; $eMaildata[$a].getContent())
	//$content:=$eMaildata[$a].getContent()
	//$BlobText:=BLOB to text($content; UTF8 text without length)
	//APPEND TO ARRAY($arAttachBLOBTxt; $BlobText)
	//End for 
	//OB SET ARRAY($oMailAttach; "attachments"; $arAttachBLOBTxt)
	
	emailSendStartProcess($oMailInfo; $BlobContainter)  //$oMailAttach)
End if 

