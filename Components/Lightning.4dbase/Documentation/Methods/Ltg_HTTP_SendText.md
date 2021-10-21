 <!--
    Ltg_HTTP_SendText ( text [text] )
    
    Sends text to the client.
 -->
 
# Ltg_HTTP_SendText

*Ltg_HTTP_SendText* ( _text_ [text] )

## Description

Sends text to the client.

## Parameters

 Parameter    | Description                                    | Type
------------  |-------------                                   |-------------
*text*        | Text to send to the client                     | [text]

## Example

```4d
Ltg_HTTP_SendText (JSON Stringify($oDataTable))
```