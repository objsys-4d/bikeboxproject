 <!--
    Ltg_Shutdown -> error [longint]
        
    Shutdown processing of Lightning web connection requests.
 -->
 
# Ltg_Shutdown

*Ltg_Shutdown* -> error [longint]

## Description

Shutdown processing of Lightning web connection requests. The method should be called from either the On Exit (4D) or On Server Shutdown (4D Server) Database Methods.
Regardless of the return value, no further Lightning web connection requests will be accepted after calling this method.

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]