<!--
    Ltg_Session_Close ( id [text] ) -> error [longint]
        
    Closes the session.
-->
 
# Ltg_Session_Close

*Ltg_Session_Close* ( _id_ [text] ) -> error [longint]

## Description

Closes the session. 

## Parameters

 Parameter    | Description       | Type
------------  |-------------      |-------------
*id*          | Session id        | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]

## Example

```4d
    Ltg_Session_Close (Connection.session.LTGSID)
```

## See also

**Ltg_Conn_Get**