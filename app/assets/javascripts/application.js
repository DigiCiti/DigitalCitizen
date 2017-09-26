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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .





// ported js from sinatra version of app... it handles ajax of member search result
// but is probably not directly useful in it's current state:
// $(document).ready(function() {
//   memberSearchListener();
// });
//
// var memberSearchListener = function () {
//   $("#member-search").on('submit', function (e) {
//     e.preventDefault();
//
//     var $memberSearchForm = $(this);
//     var url = $(this).attr('action');
//     var method = $(this).attr('method');
//     var data = $(this).serialize();
//
//     $.ajax({
//       url: url,
//       method: method,
//       data: data
//     })
//     // console.log(data);
//     .done(function(response) {
//       $('#search-result-holder').html(response);
//       console.log("success");
//     })
//     .fail(function(r) {
//       console.log("error ajaxing in the politician", r);
//     });
//
//
//   })
// }
