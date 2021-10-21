If (GEN_Listbox_ClickedEmpty(->Attachmentslb))
	OBJECT SET ENABLED:C1123(btAttach_Rem; False:C215)
Else 
	OBJECT SET ENABLED:C1123(btAttach_Rem; True:C214)
End if 