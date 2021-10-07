<!--
    Ltg_Session_New
        
    Creates a new session for the client using a session cookie (LTGSID).
-->
 
# Ltg_Session_New

*Ltg_Session_New*

## Description

Creates a new session for the client using a session cookie (LTGSID), and is erased when the session is closed.

## Example

### 4D

```4d
    // CREATE A NEW SESSION
    
    Ltg_Session_New 

    // REFER TO THE METHOD "WEB_ROUTER" IN THE STARTER TO SEE HOW THIS WORKS WITH THE URL

    // REDIRECT?

    If (Connection.data.userRedirect#"")
	
	   Connection.url :=Connection.data.userRedirect
	
    Else 
        // DEFAULT TO THE DASHBOARD
	
        Connection.url :="/"
    End if 
```

### HTTP Header

```4d
    Cookie: LTGSID=F1558743B941430DB19BFB6B7EDDE8BA
```

## See also

**Ltg_Conn_Get**

**Ltg_Session_Close**