// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/widgets/autocomplete
//= require bootstrap
//= require ckeditor/init
//= require jquery.raty
//= require ratyrate
//= require_tree .



$("#search").keyup(function() {
debugger
  $("#search").addClass("loading"); 
  var form = $("#search-form"); 

  var url = "http://localhost:3000/articles.json";    
  var formData = form.serialize(); // grab the data in the form   
  $.get(url, formData, function(html) { // perform an AJAX get

    $("#search").removeClass("loading"); // hide the spinner

    $("#test").html(html); // replace the "results" div with the results

  });

}); 