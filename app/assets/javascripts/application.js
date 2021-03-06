// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree 
//= require gritter 

$(function() {
    $(document).foundation();
});

$(function() {

    var clearAlert = setTimeout(function() {
        $(".alert-box.info").fadeOut('slow')
    }, 15000);

    $(document).on("click", ".alert-box.info a.close", function(event) {
        clearTimeout(clearAlert);
    });

    $(document).on("click", ".alert-box a.close", function(event) {
        event.preventDefault();
        $(this).closest(".alert-box").fadeOut(function(event) {
            $(this).remove();
        });
    });

});