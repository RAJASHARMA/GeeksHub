$( document ).ready(function() {
    $("#article-content").find("pre").after("<button class='btn btn-default' onclick='send_code(this)' data-remote='true'>Run</button><br/><br/><div class='output'></div><br/>")
});

function send_code(run_button) {
    $(run_button).html("<i class='fa fa-refresh fa-spin'></i> Loading");
    output_div = run_button.nextElementSibling.nextElementSibling.nextElementSibling
    code_div = run_button.previousElementSibling.childNodes[0];
    code = code_div.textContent;
    lang = code_div.className.split("_")[1];
    langVersion = code_div.className.split("_")[2];

    $(output_div).html("");
    $(output_div).removeClass("output-padding");
    
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
            $(output_div).addClass("output-padding");
            $(output_div).html("<u>Output: </u>" + " Time: " + cpuTime + " Memory: " + memory + "<hr/>" + output).hide().slideDown(500);
            $(run_button).html("Run"); 
             
        },
        error: function (data) {  
            $(output_div).html("<u>Output:</u><br>" + output);
            $(run_button).html("Run");
            $(output_div).addClass("output-padding"); 
        }
    });
}