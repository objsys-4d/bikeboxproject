//%attributes = {}
C_OBJECT:C1216($1)

C_OBJECT:C1216($oSettings)  // SETTINGS OBJECT

$oSettings:=$1

  // DEFAULT USER FORM SETTINGS?

If (OB Get type:C1230(oUser;$oSettings.form)=Is undefined:K8:13)
	
	oUser[$oSettings.form]:=New object:C1471
	
	  // PAGINATION...
	
	oUser[$oSettings.form].pageNumber:=1
	oUser[$oSettings.form].pageSize:=10
	oUser[$oSettings.form].pageCount:=0
	
	  // SEARCH...
	
	oUser[$oSettings.form].searchString:=""
	oUser[$oSettings.form].searchFilter:=$oSettings.searchFilter
	
	  // SORT...
	
	oUser[$oSettings.form].sortField:=$oSettings.sortField
	oUser[$oSettings.form].sortOrder:=$oSettings.sortOrder
End if 

  // PROCESS ACTION...

Case of 
	: (oConnection.action="first")  // FIRST PAGE
		
		oUser[$oSettings.form].pageNumber:=1
		
	: (oConnection.action="previous")  // PREVIOUS PAGE
		
		oUser[$oSettings.form].pageNumber:=oUser[$oSettings.form].pageNumber-1
		
		If (oUser[$oSettings.form].pageNumber<1)
			
			oUser[$oSettings.form].pageNumber:=1
		End if 
		
	: (oConnection.action="next")  // NEXT PAGE
		
		If (oUser[$oSettings.form].pageNumber<oUser[$oSettings.form].pageCount)
			
			oUser[$oSettings.form].pageNumber:=oUser[$oSettings.form].pageNumber+1
		End if 
		
	: (oConnection.action="last")  // LAST PAGE
		
		oUser[$oSettings.form].pageNumber:=oUser[$oSettings.form].pageCount
		
	: (oConnection.action="pageSize-@")  // PAGE SIZE
		
		oUser[$oSettings.form].pageNumber:=1
		oUser[$oSettings.form].pageSize:=Num:C11(Substring:C12(oConnection.action;10))
End case 

  // SEARCH ACTION?

If (oConnection.action="search")
	
	  // SAVE SEARCH STRING & FILTER VALUES...
	
	oUser[$oSettings.form].searchString:=oConnection.data.searchString
	oUser[$oSettings.form].searchFilter:=oConnection.data.searchFilter
Else 
	
	  // RESTORE SEARCH STRING & FILTER VALUES...
	
	oConnection.data.searchString:=oUser[$oSettings.form].searchString
	oConnection.data.searchFilter:=oUser[$oSettings.form].searchFilter
End if 

  // RESET PAGE NUMBER?

If ((oConnection.action="search") | (oConnection.action="sort") | (oConnection.action="tab"))
	
	oUser[$oSettings.form].pageNumber:=1
End if 

  // SORT ACTION?

If (oConnection.action="sort")
	
	  // SORT FIELD CHANGED?
	
	If (oConnection.record#oUser[$oSettings.form].sortField)
		
		oUser[$oSettings.form].sortField:=oConnection.record
		oUser[$oSettings.form].sortOrder:="asc"
	Else 
		
		  // TOGGLE SORT ORDER...
		
		If (oUser[$oSettings.form].sortOrder="asc")
			
			oUser[$oSettings.form].sortOrder:="desc"
		Else 
			
			oUser[$oSettings.form].sortOrder:="asc"
		End if 
	End if 
End if 