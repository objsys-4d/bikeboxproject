/*
 Name:	app.js
 Description: Lightning V5 Starter Application JS
 Author: Graham Langley
 Version: 5.0
 Requires: Bootstrap 4.x
 */

/* AUTOCOMPLETE */

function autocompleteInit(id, method) {
    
    ltgObj(id).on('click', 'a',
    
    function () {
        
        var value = encodeURIComponent($(this).text());
        
        autocompleteHide(id);
        
        ltgExecuteMethod(method, value);
    });
}

function autocompleteShow(id) {
    
    ltgObj(id).height($(window).height());
    
    // SET THE WIDTH OF THE LIST TO THE WIDTH OF THE PREVIOUS DIV AS THIS WILL BE THE INPUT FIELD CONTAINER
    
    ltgObj(id).width(ltgObj(id).prev().width());
    
    ltgObj(id).css('display', 'inline-block');
}

function autocompleteHide(id) {
    
    ltgObj(id).css('display', 'none');
}

function autocompleteToggle(id, method) {
    
    var display = ltgObj(id).css('display');
    
    if (display == 'none') {
        
        ltgExecuteMethod(method, '@');
        
        autocompleteShow(id);
    } else {
        
        autocompleteHide(id);
    }
}

/* NOTIFICATIONS */

function notificationsNew(type, icon, description)  {

    var now = new Date().toLocaleTimeString();

    // REMOVE PREVIOUS BADGE CLASS

    ltgObj('notifications_counter').removeClass('badge-danger');
    ltgObj('notifications_counter').removeClass('badge-success');

    // ADD CURRENT BADGE CLASS

    ltgObj('notifications_counter').addClass('badge-'+type);

    // CREATE NOTIFICATION...

    var notification = '<a class="dropdown-item d-flex align-items-center" href="#">';

    notification+='<div class="mr-3">';
    notification+='<div class="icon-circle bg-'+type+'"><i class="'+icon+'"></i></div>';
    notification+='</div>';
    notification+='<div>';
    notification+='<div class="small text-gray-500">'+now+'</div><span class="font-weight-Bold">'+description+'</span></div>';
  
    notification+='</a>';
    
    // ADD NOTIFICATION

    ltgObj('notifications').prepend(notification);

    // UPDATE COUNTER
    
    var counter = $( "#notifications .dropdown-item" ).length;

    ltgObj('notifications_counter').html(counter);
}

function notificationsClear()  {

    ltgObj('notifications').html('');

    ltgObj('notifications_counter').html('');
}