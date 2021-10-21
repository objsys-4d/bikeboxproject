 <!--
    Ltg_File_Upload ( blob [pointer] ) -> file [object]
    
    $oDocument :=Ltg_File_Upload (->$bloDocument)
    
    Uploads a file from the client.
 -->
 
# Ltg_File_Upload

*Ltg_File_Upload* ( _blob_ [pointer] ) -> _file_ [object]

## Description

Uploads a file from the client.


## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*blob*        | File content                      | [pointer]

## Result

 Result       | Description                       | Type
------------  |-------------                      |-------------
*file*        | File object                       | [object]

## File Object

 Property     | Description                       | Type
------------  |-------------                      |-------------
*name*        | File name                         | [text]
*type*        | File mime type                    | [text]
*size*        | File size                         | [longint]


## Example

### HTML

```4d
    <div class="input-group mb-4">
        <input class="form-control-file" type="file" id="file-1" name="file-1"/>
    </div>
                        
    <div class="input-group">
        <button class="btn btn-secondary" onclick="ltgFileUpload('file-1','Demos_File_Upload');">Upload</button>
    </div>
```

### 4D

```4d
    // Demos_File_Upload
      
    C_BLOB($bloDocument)
    
    C_OBJECT($oDocument)
    
    C_TEXT($txtFolder)
    
    $oDocument :=Ltg_File_Upload (->$bloDocument)
    
      // SAVE TO THE "UPLOADS" FOLDER  
    
    $txtFolder:=Connection.webFolder+"uploads"+Folder separator
    
    BLOB TO DOCUMENT($txtFolder+$oDocument.name;$bloDocument)
```


