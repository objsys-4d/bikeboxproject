 <!--
    Ltg_User_Get ( name [text] ) -> user [object]
        
    Gets the user object associated with name.
 -->
 
# Ltg_User_Get

*Ltg_User_Get* ( _name_ [text] ) -> _user_ [object]

## Description

Gets the user object associated with _name_.

## Parameters

 Parameter    | Description            | Type
------------  |-------------           |-------------
*name*        | User name              | [text]

## Result

 Result       | Description            | Type
------------  |-------------           |-------------
*user*        | User object            | [object]

```4d
    C_OBJECT($oUser)
    
    $oUser :=Ltg_User_Get ("Administrator")
```
```4d
    {
    	"userName": "Administrator",
    	"companiesList": {
    		"pageNumber": 1,
    		"pageSize": 10,
    		"pageCount": 49,
    		"searchString": "",
    		"searchFilter": "name",
    		"sortField": "Company_Name",
    		"sortOrder": "asc"
    	},
    	"ordersList": {
    		"pageNumber": 1,
    		"pageSize": 10,
    		"pageCount": 0,
    		"searchString": "",
    		"searchFilter": "number",
    		"sortField": "Order_ID",
    		"sortOrder": "asc"
    	},
    	"companiesDetail": {
    		"pageNumber": 464,
    		"pageSize": 10,
    		"pageCount": 486,
    		"searchString": "",
    		"searchFilter": "",
    		"sortField": "",
    		"sortOrder": ""
    	},
    	"contactsList": {
    		"pageNumber": 1,
    		"pageSize": 10,
    		"pageCount": 0,
    		"searchString": "",
    		"searchFilter": "name",
    		"sortField": "Contact_Name",
    		"sortOrder": "asc"
    	}
    }
```

## See also

**Ltg_Users_Get**