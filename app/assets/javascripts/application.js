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


//for codesnipet
$( document ).ready(function() {
    $("#article-content").find("pre").after("<button onclick='send_code(this)' data-remote='true'>Run</button><br/><br/><div class='output'></div><br/>")
});

function send_code(run_button) {
    $(run_button).html("<i class='fa fa-refresh fa-spin'></i>Loading");
    output_div = run_button.nextElementSibling.nextElementSibling.nextElementSibling
    code_div = run_button.previousElementSibling.childNodes[0];
    code = code_div.textContent;
    lang = code_div.className.split("_")[1];
    langVersion = code_div.className.split("_")[2];
    $(output_div).html("");
    
    $.ajax({ 
        type: "POST", 
        url: '/articles/execute_code',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},  
        data: {code: code, lang: lang, version: langVersion}, 
        dataType: "script",
        success: function(data) {
            data = JSON.parse(data);
            output = data["output"];
            cpuTime = Math.round(data["cpuTime"] * 1000) / 1000;
            memory = Math.round(data["memory"] * 1000) / 1000;
            // debugger
            output = output.replace("\n", "<br>");
            $(output_div).html("<u>Output: </u>" + " Time: " + cpuTime + " Memory: " + memory + "<hr/>" + output);
            $(run_button).html("Run"); 
            $(output_div).addClass("output-padding"); 
        },
        error: function (data) {  
            console.log('Error in Operation');  
            $(output_div).html("<u>Output:</u><br>" + output);
            $(run_button).html("Run");
            $(output_div).addClass("output-padding"); 
        }
    });

}