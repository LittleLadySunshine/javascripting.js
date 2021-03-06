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
//= require tablednd
//= require underscore
//= require zeroclipboard
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  var menu = $('#navigation-menu');
  var menuToggle = $('#js-mobile-menu');

  $(menuToggle).on('click', function(e) {
    e.preventDefault();
    menu.slideToggle(function(){
      if(menu.is(':hidden')) {
        menu.removeAttr('style');
      }
    });
  });

  $(document).on("click", "[data-prevent-jump]", function(){
    return false;
  });

  new ZeroClipboard($("[data-clipboard-text]"));

  $(document).on("ajax:success", "[data-behavior=mark-as-read] a", function(e){
    $(this).closest("[data-behavior=mark-as-read]").remove();
  });
});
