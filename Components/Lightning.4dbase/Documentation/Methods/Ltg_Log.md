<!--
    Ltg_Log ( type [text] ; description [text] ; { ; value [text] } )
        
    Adds a custom event to the connection log.
-->
 
# Ltg_Log

*Ltg_Log* ( _type_ [text] ; _description_ [text] { ;  _value_ [text] } )

## Description

Adds a custom event to the connection log.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*type*        | Event type, "error" or "information"  | [text]
*description* | Event description                     | [text]
*value*       | Event value (optional)                | [text]

## Example

```4d
    Ltg_Log( "error"; "custom error description"; "badvalue" )
```

## See also

**Ltg_Conn_Get**