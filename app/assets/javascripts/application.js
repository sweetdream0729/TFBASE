// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// do not require rails-ujs
// do not require activestorage
// do not require turbolinks
//= require libs.min
//= require jquery_ujs
//= require owl.carousel
//= require interface
//= require remote_form_in_popup
//= require hos_n_con_form
//= require sub_filter
//= require tickets
//= require jquery.tab.min
// do not require_tree .

$(document).ready(function(){
  $(".owl-carousel").owlCarousel({
    nav: true,
    dots: true,
    autoplay: true,
    autoplayHoverPause: true,
    responsive: {
      0: {
        items: 1
      },
      820: {
        items: 2,
        margin: 54
      },
      1230: {
        items: 3,
        margin: 54
      }
    },
    navContainerClass: 'owl-spec-nav',
    navClass: ['owl-spec-prev','owl-spec-next']
  });

  $('#tab').tab({
    triggers: ['#button1', '#button2', '#button3', '#button4', '#button5', '#button6', '#button7', '#button8'],
    contents: ['#content1', '#content2', '#content3', '#content4', '#content5', '#content6', '#content7', '#content8'],
    defaultIndex: 0,
    activeClass: 'tab-active',
    keyName: 'tab'
  });

  $('#main-top-form-query').autocomplete({
    source: '/events/autocomplete_list',
    appendTo: '#main-top-search-form'
  });
});
