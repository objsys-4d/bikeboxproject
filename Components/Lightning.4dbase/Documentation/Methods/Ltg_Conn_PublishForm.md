 <!--
    Ltg_Conn_PublishForm( form [text] ) -> error [longint]
    
    Ltg_Conn_PublishForm ("companies-list.html")
    
    Publishes an HTML form, using the Web Folder as the root and may use Lightning directives for processing.
 -->
 
# Ltg_Conn_PublishForm

*Ltg_Conn_PublishForm* ( _form_ [text] ) -> _error_ [longint]

## Description

Publishes an HTML form, using the Web Folder as the root and may use Lightning directives for processing.

## Parameters

 Parameter     | Description                       | Type
------------   |-------------                      |-------------
*form*         | Form name                         | [text]

## Result

 Result        | Description                       | Type
------------   |-------------                      |-------------
*error*        | Error code                        | [longint]

## Directives

Lightning directives are written inside double braces _{{directive}}_

You can place a _{{directive}}_ in your html form and it is processed by Lightning to execute a method, get data or localise text.

 Directive                          | Description      
------------                        |-------------
*{{method[/parameter,...]}}*        | Executes a 4D method with optional text parameters  
*{{.property}}*                     | Get the value of a general property using dot notation
*{{object.property}}*               | Get the value of an object property using dot notation
*{{%text}}*                         | Get the localised target of the text, using the % prefix (localise callback method)

## Example

```4d
Ltg_Conn_PublishForm ("index.html")
```

### Method

```4d
{{Index_Form}}
```

### .Property

```4d
<input id=".searchString" name=".searchString" value="{{.searchString}}" />      
```

### Object.Property

```4d
<input type="text" id="Company.City" name="Company.City" value="{{Company.City}}" />    
```

### Localise

```4d
<span id="dashboard_menu">{{%dashboard}}</span></a>
```

