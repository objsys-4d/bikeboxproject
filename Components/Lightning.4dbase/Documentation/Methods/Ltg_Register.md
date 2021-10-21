<!--
    Ltg_Register ( name [text] ; number [text] ) -> error [longint]
        
    Validates your licence information. The method should be called immediately after Ltg_Startup.
-->

# Ltg_Register

*Ltg_Register* ( _name_ [text] ; _number_ [text] ) -> [longint]

## Description

Validates your licence information. The method should be called immediately after _Ltg_Startup_.

## Parameters

 Parameter      | Description                       | Type
------------    |-------------                      |-------------
*name*          | Name of the license holder        | [text]
*number*        | Licence number                    | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]
