
$doc:=Select document:C905(""; "*"; "Please select a file to attach"; 0)
If (OK=1)  //If a document was selected
	C_BLOB:C604($blankBLOB)
	APPEND TO ARRAY:C911(atAttachments; $doc)
	APPEND TO ARRAY:C911(atAttachmentsPath; Document)
	APPEND TO ARRAY:C911(atAttachmentsBLOB; $blankBLOB)
	APPEND TO ARRAY:C911(atAttachmentsType; "file")
End if 