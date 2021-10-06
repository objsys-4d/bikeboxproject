If (vtNavBtnTxt="Add") | (vtNavBtnTxt="Edit")  //we are in the middle of adding/editing record, did not hit SAVE
	vtNavBtnTxt:=""
	REJECT:C38
	
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
End if 
