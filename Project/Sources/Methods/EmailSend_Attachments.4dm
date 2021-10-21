//%attributes = {}
// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/13/21, 20:29:50
// ----------------------------------------------------
// Method: EmailSend_Attachments
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BLOB:C604(vblMailAttach)
ARRAY BOOLEAN:C223(Attachmentslb; 0)
ARRAY TEXT:C222(atAttachments; 0)
ARRAY TEXT:C222(atAttachmentsPath; 0)
ARRAY TEXT:C222(atAttachmentsType; 0)
ARRAY BLOB:C1222(atAttachmentsBLOB; 0)

If (BLOB size:C605(vblMailAttach)#0)
	ARRAY BLOB:C1222($arAttachBLOB; 0)
	ARRAY TEXT:C222($arAttachBLOBfileName; 0)
	BLOB_BLOBToVars(->vblMailAttach; ->$arAttachBLOB; ->$arAttachBLOBfileName)
	
	COPY ARRAY:C226($arAttachBLOB; atAttachmentsBLOB)
	COPY ARRAY:C226($arAttachBLOBfileName; atAttachments)
	For ($i; 1; Size of array:C274(atAttachments))
		APPEND TO ARRAY:C911(atAttachmentsType; "blob")
		APPEND TO ARRAY:C911(atAttachmentsPath; "")
	End for 
End if 

//For ($i; 0; vcMailAttach.length-1)
//APPEND TO ARRAY(atAttachmentsPath; "")
//APPEND TO ARRAY(atAttachmentsBLOBTxt; vcMailAttach[$i][0])
//APPEND TO ARRAY(atAttachments; vcMailAttach[$i][1])
//End for 
