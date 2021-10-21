 <!--
    Ltg_Conn_ProcessRequest( url [text]; header [text]; clientIP [text]; serverIP [text] ) -> error [longint]    
    
    Processes a web connection request.
 -->
 
# Ltg_Conn_ProcessRequest

*Ltg_Conn_ProcessRequest* ( _url_ [text]; _header_ [text]; _clientIP_ [text]; _serverIP_ [text] ) -> _error_ [longint] 

## Description

Processes a web connection request. This method can be called in the _On Web Connection_ Database Method, or the NTK equivalent you have created in your host database.

## Parameters

 Parameter     | Description                                    | Type
------------   |-------------                                   |-------------
*url*          | URL                                            | [text]
*header*       | HTTP header                                    | [text]
*clientIP*     | Client ip address (browser)                    | [text]
*serverIP*     | Server ip address                              | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]

## Example

```4d
    // On Web Connection - Database Method
      
    C_TEXT($1)  // URL
    C_TEXT($2)  // HTTP HEADER
    C_TEXT($3)  // CLIENT IP ADDRESS
    C_TEXT($4)  // SERVER IP ADDRESS
    
    C_LONGINT($nError)  // LIGHTNING ERROR CODE
    
      // CONNECT TO LIGHTNING AND PROCESS THE REQUEST
    
    $nError :=Ltg_Conn_ProcessRequest ($1;$2;$3;$4)
```
