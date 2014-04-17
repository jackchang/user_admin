// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require_tree .
// provides jqgrid jquery plugin from gem 'jqgrid-jquery-rails':
//= require jqgrid-jquery-rails

function setup_edit_user_dialog(){
  $("#edit_user").dialog({                                                                    
    autoOpen: false,
    width: 450,
    buttons: {
      "Cancel": function(){
        $(this).dialog("close");
      } 
    } 
  }); 
}

function setup_add_user_dialog(){
  $("#add_user").dialog({                                                                    
    autoOpen: false,
    width: 450,
    buttons: {
      "Cancel": function(){
        $(this).dialog("close");
      }
    } 
  }); 
}

$(window).bind('resize', function() {
  $("#users_list").setGridWidth($(window).width() * 0.95);
}).trigger('resize');

$(document).ready(function(){
  setup_edit_user_dialog();
  setup_add_user_dialog();
  $(window).resize();
  
  $("#edit_button").click(function(){
   var gr = jQuery("#users_list").jqGrid('getGridParam','selrow'); 
   if( gr != null ) 
    $.get('/users/' + gr + '/edit');
   else alert("Please Select Row"); });

   $("#add_button").click(function(){ $.get('/users/new') });

   $("#role_button").click(function(){window.open("/roles", "Add/Edit Roles", 'width=800, height=500')});
});

