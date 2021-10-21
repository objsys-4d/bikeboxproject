<!--
    Ltg_HTTP_SetHeader ( name [text] ; value [text] )
        
    Set the value of the HTTP header name.
-->
 
# Ltg_HTTPD_SetHeader

*Ltg_HTTP_SetHeader* ( _name_ [text] ; _value_ [text] )

## Description

Set the value of the HTTP header name.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*name*        | HTTP header name                      | [text]
*value*       | HTTP header value                     | [text]

## Example

```4d
    // SET THE PAYLOAD TYPE FOR THE CLIENT
    
    Ltg_HTTP_SetHeader ("VND.Lightning.Payload";oConnection.responseType)
```