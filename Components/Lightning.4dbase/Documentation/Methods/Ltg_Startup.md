<!--
    Ltg_Startup ( webserver [text] ) -> error [longint]
    
    Startup Lightning to accept web connection requests.
-->

# Ltg_Startup

*Ltg_Startup* ( _webserver_ [text] ) -> error [longint]

## Description

Startup Lightning to accept web connection requests. 

This method should be called by either the On Startup (4D) or On Server Startup (4D Server) database methods.

The _webserver_ parameter allows you to specify which Web Server to use for connection requests, 4D or NTK.

## Parameters

 Parameter                 | Description                                      | Type
------------               |-------------                                     |-------------
*webserver*                | Web Server - 4D or NTK                           | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]


## Example

```4d
    // 4D WEB SERVER
    
    $nError :=Ltg_Startup ("4D"
    
    // NTK WEB SERVER
    
    $nError :=Ltg_Startup ("NTK")
```