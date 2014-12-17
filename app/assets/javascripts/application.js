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
//= require jquery.min
//= require jquery-ui.min
//= require turbolinks
//= require jquery.zrssfeed
//= require jquery.vticker
//= require d3.v3.min
//= require jquery.widget.min
//= require jquery.mousewheel
//= require jquery.easing.1.3.min
//= require flat-ui.min
//= require angular
//= require app
//= require jquery.animsition.min
//= require readhistry

//= require_tree .

$(document).ready(function() {
  $(".animsition").animsition({
    inClass               :   'fade-in',
    outClass              :   'fade-out',
    inDuration            :    1500,
    outDuration           :    800,
    linkElement           :   '.animsition-link', 
    // e.g. linkElement   :   'a:not([target="_blank"]):not([href^=#])'
    touchSupport          :    true, 
    loading               :    true,
    loadingParentElement  :   'body', //animsition wrapper element
    loadingClass          :   'animsition-loading',
    unSupportCss          : [ 'animation-duration',
                              '-webkit-animation-duration',
                              '-o-animation-duration'
                            ]
  });
  
});

