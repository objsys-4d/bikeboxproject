

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		vtActiveBt:="Donations"
		ObjForm_SubformLoad(vtActiveBt)
		OBJECT SET ENABLED:C1123(*; "navBtn_S@"; False:C215)  //we cannot Edit or Delete in this form
End case 