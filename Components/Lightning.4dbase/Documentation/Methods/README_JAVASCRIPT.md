# ltgAccordionPanelSetActive

*ltgAccordionPanelSetActive* ( _id_ [text] )

## Description

Activates an accordion panel.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*id*          | The id of the accordion panel             | [text]

## Example

```4d
    Ltg_JS_Send ("ltgAccordionPanelSetActive('accordion-panel-1')")
```

# ltgAccordionPanelSetIcon

*ltgAccordionPanelSetIcon* ( _id_ [text], _icon_ [text] )

## Description

Changes the icon of an accordion panel header.

## Parameters

 Parameter    | Description                               | Type
------------  |-------------                              |-------------
*id*          | The id of the accordion panel header      | [text]
*icon*        | FontAwesome icon class                    | [text]

## Example

```4d
    Ltg_JS_Send ("ltgAccordionPanelSetIcon('accordion-header-1','fa fa-thumbs-up')")
```

# ltgAccordionPanelSetTitle

*ltgAccordionPanelSetTitle* ( _id_ [text], _title_ [text] )

## Description

Changes the title of an accordion panel header.

## Parameters

 Parameter    | Description                               | Type
------------  |-------------                              |-------------
*id*          | The id of the accordion panel header      | [text]
*title*       | Title                                     | [text]

## Example

```4d
    Ltg_JS_Send ("ltgAccordionPanelSetTitle('accordion-header-1','Panel 1 (activated)')")
```

# ltgDialogOpen

*ltgDialogOpen* ( _id_ [text] )

## Description

Opens a dialog.

## Parameters

 Parameter    | Description                        | Type
------------  |-------------                       |-------------
*id*          | The id of the dialog               | [text]

## Example

### HTML

```4d
    <div class="modal" id="demo-dialog" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Dialog</h5>
                    <button type="button" class="close" onclick="ltgDialogClose('demo-dialog');" aria-label="{{%cancel}}">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="demo-dialog-content"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                        onclick="ltgDialogClose('demo-dialog');">{{%cancel}}</button>
                </div>
            </div>
        </div>
    </div>
```

### 4D

```4d
    // UPDATE DIALOG CONTENT
    
    Ltg_JS_Send ("ltgObj('demo-dialog-content').html('"+"Dialog opened at "+String(Current time(*)+"')")

    // OPEN DIALOG

    Ltg_JS_Send ("ltgDialogOpen('demo-dialog')")
```

# ltgDialogClose

*ltgDialogClose* ( _id_ [text] )

## Description

Closes a dialog.

## Parameters

 Parameter    | Description                        | Type
------------  |-------------                       |-------------
*id*          | The id of the dialog               | [text]

## Example

```4d
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary"
            onclick="ltgDialogClose('demo-dialog');">{{%cancel}}</button>
    </div>
```

# ltgExecuteMethod

*ltgExecuteMethod* ( _method_ [text] { , _parameter_ [text] })

## Description

Execute a 4D _method_, with optional _parameter_.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*method*      | 4D method name                    | [text]
*parameter*   | Parameter (optional).             | [text]

## Example

```4d
    <li class="nav-item" onclick="ltgExecuteMethod('Demos_Tabs','tabs-tab-1');">
```

# ltgFileUpload

*ltgFileUpload* ( _id_ [text] , _method_ [text] )

## Description

Ajax file upload.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*id*          | The id of the file input          | [text]
*method*      | 4D method name                    | [text]


## Example

```4d
    <div class="input-group mb-4">
        <input class="form-control-file" type="file" id="file-1" name="file-1"/>
    </div>
                    
    <div class="input-group">
        <button class="btn btn-secondary" onclick="ltgFileUpload('file-1','Demos_File_Upload');"><i class="fa fa-upload"></i> Upload</button>
     </div>
```

# ltgFormAction

*ltgFormAction* ( _parameters_ [text] )

## Description

Processes a form action.

## Parameters

*parameters*  are in the style of a url query string.

 Parameter    | Description                                     | Type
------------  |-------------                                    |-------------
*form*        | Form name (optional, default is current form)   | [text]
*action*      | Form action (see Actions)                       | [text]
*method*      | Execute a 4D method                             | [text]
*modal*       | Modal form (this can be an independent form)    | [boolean]
*record*      | Record selector                                 | [text]

## Actions

 Action       | Description                                     | Type
------------  |-------------                                    |-------------
*select*      | Adds or removes (toggles) a record selector     | [text]

## Example

```4d

    <input type="checkbox" onclick="ltgFormAction('?action=select&record={{Order.Order_ID}}');">

    <button type="button" onclick="ltgFormAction('?action=save&record={{Order.Order_ID}}&method=Order_Save');">Save</button>

    <button type="button" onclick="ltgFormAction('companies-detail.html?action=delete&method=Company_Delete');">Delete</button>

    // DataTables.js
    
    <a href="#" onclick="ltgFormAction(\'contacts-detail.html?action=edit&modal=true&record='+row[0]+'\');">'+data+'</a>';
```

# ltgLogout

*ltgLogout* ( _url_ [text] )

## Description

Logout the current user via a url using a form submit.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*url*         | URL                               | [text]

## Example

### HTML

```4d
    <a class="btn btn-primary" href="#" onclick="ltgLogout('logout');">Logout</a>
```

### 4D

```4d
    // LOGOUT ?

    If ((Connection.url="/logout") 
	
        // CLOSE THE SESSION
        
        User_Logout 
    End if 
```

# ltgObj

*ltgObj* ( _id_ [text] ) -> _object_ [jQuery object]

## Description

Returns _id_ as a jQuery object.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*id*          | The id of an html element         | [text]

## Example

```4d
    Ltg_JS_Send ("ltgObj('.searchString').val('"+oUser.companiesList.searchString+"')")

    Ltg_JS_Send ("ltgObj('companies-pagination').css('display','none')")
```

# ltgObjFocus

*ltgObjFocus* ( _id_ [text] )

## Description

Set the input focus to the element associated with _id_.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*id*          | The id of an html element         | [text]

## Example

```4d
    Ltg_JS_Send ("ltgObjFocus('.userName')")
```

# ltgObjSynch

*ltgObjSynch* ( _id_ [text], _value_ [text] )

## Description

Synchronise the value of an element when it has multiple instances in a form.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*id*          | The id of an html element         | [text]
*value*       | The value to synchronise          | [text]

## Example

```4d
    <!--SEARCH-->
    <div class="d-none" id="navbar-search">
        <div class="d-none d-sm-inline-block form-inline mr-auto ml-md-1 my-2 my-md-0 mw-100 navbar-search">     
            <div class="input-group">
                <select class="custom-select bg-light small" id=".searchFilter" name=".searchFilter" onchange="ltgObjFocus('.searchString');"></select>
                  
                  <input class="form-control bg-light" id=".searchString" name=".searchString"
                    onkeypress="ltgObjSynch('.searchString', this.value); return ltgSearchSubmit(event);" onchange="ltgObjSynch('.searchString', this.value);" placeholder="{{%search}}..." type="text" aria-label="{{%search}}" aria-describedby="basic-addon2" value="{{.searchString}}" />
                                
                 <div class="input-group-append">
                    <button class="btn btn-primary" onclick="return ltgSearchSubmit();" type="button">
                      <i class="fas fa-search fa-sm"></i>
                    </button>
                </div> 
            </div>
        </div>
    </div>
    <!--/SEARCH-->
            
    <!--SEARCH (Visible Only XS)-->
    <li class="nav-item dropdown no-arrow d-sm-none">
        <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="fas fa-search fa-fw"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
            <div class="input-group">
                <input class="form-control bg-light border-0 small" id=".searchString" name=".searchString"
                    onkeypress="ltgObjSynch('.searchString', this.value);return ltgSearchSubmit(event);" placeholder="{{%search}}..." type="text" aria-label="{{%search}}" aria-describedby="basic-addon2" value="{{.searchString}}" />
                <div class="input-group-append">
                        <button class="btn btn-primary" onclick="return ltgSearchSubmit();" type="button">
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
            </div>
        </div>
    </li>             
    <!--/SEARCH-->
```

# ltgQCHide

*ltgQCHide*

## Description

Hides quality control, if enabled.

## Example

```4d
    Ltg_JS_Send ("ltgQCHide()")
```

# ltgQCPopover

*ltgQCPopover*

## Description

Displays the quality control information, if enabled.

## Example

```4d
    <a class="dropdown-item" href="#" onclick="ltgQCPopover();">
```

# ltgSearchSubmit

*ltgSearchSubmit* ( _event_ [object] )

## Description

Perform a “search” action for a form. The function call can be attached to the *onkeypress* or *onchange* attributes.

## Parameters

 Parameter    | Description                       | Type
------------  |-------------                      |-------------
*event*       | Browser event object              | [object]

## Example

```4d
     <input class="form-control bg-light" id=".searchString" name=".searchString"
        onkeypress="return ltgSearchSubmit(event);" placeholder="Search..." type="text" value="{{.searchString}}" />      
```

# ltgSelectAddOption

*ltgSelectAddOption* ( _id_ [text] , _value_ [text] , _description_ [text] )

## Description

Adds an option to a select list.

## Parameters

 Parameter          | Description                              | Type
------------        |-------------                             |-------------
*id*                | The id of the select list                | [text]
*value*             | The value of the option                  | [text]
*description*       | The description of the option            | [text]

## Example

### HTML

```4d
    <select id="Contact.Job_Title" name="Contact.Job_Title"></select>
```

### 4D

```4d
    Ltg_JS_Send ("ltgSelectAddOption('Contact.Job_Title','Account Manager','Account Manager')")
```

# ltgSelectDeleteOptions

*ltgSelectDeleteOptions* ( _id_ [text] )

## Description

Deletes all options in a select list.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*id*          | The id of the select list             | [text]

## Example

```4d
    Ltg_JS_Send ("ltgSelectDeleteOptions('Contact.Job_Title')")
```

# ltgSelectSetValue

*ltgSelectSetValue* ( _id_ [text] , _value_ [text] )

## Description

Sets _value_ as the current option in a select list.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*id*          | The id of the select list             | [text]
*value*       | The value of the current option       | [text]

## Example

```4d
    Ltg_JS_Send ("ltgSelectSetValue('Contact.Job_Title','Director')")
```

# ltgSelectGetValue

*ltgSelectGetValue* ( _id_ [text] ) -> _value_ [text]

## Description

Gets the current option value in a select list.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*id*          | The id of the select list             | [text]

## Example

```4d
    Ltg_JS_Send ("ltgSelectSetValue('Contact.Job_Title','Director')")
```

# ltgTabSetActive

*ltgAccordionPanelSetActive* ( _id_ [text] )

## Description

Activates a tab.

## Parameters

 Parameter    | Description                           | Type
------------  |-------------                          |-------------
*id*          | The id of the tab             | [text]

## Example

```4d
    Ltg_JS_Send ("ltgTabSetActive('tabs-tab-1')")
```

# ltgTabSetIcon

*ltgTabSetIcon* ( _id_ [text], _icon_ [text] )

## Description

Changes the icon of a tab.

## Parameters

 Parameter    | Description                               | Type
------------  |-------------                              |-------------
*id*          | The id of the tab      | [text]
*icon*        | FontAwesome icon class                    | [text]

## Example

```4d
    Ltg_JS_Send ("ltgTabSetIcon('tabs-tab-1','fa fa-thumbs-up')")
```

# ltgTabSetTitle

*ltgTabSetTitle* ( _id_ [text], _title_ [text] )

## Description

Changes the title of a tab.

## Parameters

 Parameter    | Description                               | Type
------------  |-------------                              |-------------
*id*          | The id of the tab      | [text]
*title*       | Title                                     | [text]

## Example

```4d
    Ltg_JS_Send ("ltgTabSetTitle('tabs-tab-1','Tab 1 (Activated)')")
```