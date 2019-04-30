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
//= require autocomplete-rails
//= require jquery-ui/widgets/autocomplete
//= require popper
//= require bootstrap
//= require ckeditor/init
//= require ckeditor/plugins/codesnippet/plugin
//= require jquery.raty
//= require ratyrate
//= require_tree .
//= require tag
//= require article

	

$(document).ready(function(){

	$(".notice").delay(3000).slideUp();


	$("#search").keyup(function(event) {
		$("#search-values").css("background-color", "white");
	});

	$("#profile-validate").click(function(){
		var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
		
		var emailRegexValidate = regexValidation($("#profile_public_email"), $("#public-email-error"), emailRegex);
		var nameLengthValidate = lengthValidation($("#profile_name"), $("#name-error"), 3, 20);
        
    	if(nameLengthValidate ==true && emailRegexValidate ==true)
        	$("#profile_details_form").submit();
	});

	$("#image-validate").click(function(){
		var extension = $('#profile_image').val().split('.').pop().toLowerCase();
		
		if((imageValidation($("#profile_image"), $("#image-error"), extension)) == true)
			$("#image_form").submit();
		
	});
	
	$("#bio-validate").click(function(){
		$("#bio_form").submit();
	});
	$("#social-media-validate").click(function(){
		if($("#profile_facebook").val().trim() == "" && $("#profile_twitter").val().trim() == "" && $("#profile_instagram").val().trim() == "" && $("#profile_linkedin").val().trim() == "" && $("#profile_youtube").val().trim() == "")
			$("#social-media-error").slideDown().html("<span class='error'>Provide Atleast One Social Media Link</span>");
		else
		{
			$("#social-media-error").slideUp();
			$("#social_media_form").submit();
		}
	});

	$("#report-button").click(function(){
		if(blankValidation($("#report_description"),$("#report-error")))
			$("#report_form").submit();

	});

});

// bootstrap-tagsinput.js file - add in local

function blankValidation(element, errorElement)
{
	if( $(element).val().trim() == "")
	{
		$(errorElement).slideDown().html("<span class='error'>Cannot Be Blank</span>");
		$(element).css("border","solid red 1px");
		return false;
	}
	else
    {
    	$(errorElement).slideUp();
        $(element).css("border","solid black 1px");
        return true;
    }
}

function regexValidation(element, errorElement, regex)
{
	if(!(regex.test($(element).val().trim())))
    {
        $(errorElement).slideDown().html("<span class='error'>Invalid Email</span>");
        $(element).css("border","solid red 1px");
        return false;
    }
    else
    {
    	$(errorElement).slideUp();
        $(element).css("border","solid black 1px");
        return true;
    }
}

function lengthValidation(element, errorElement, minLenght, maxLength)
{
	if($(element).val().trim().length < minLenght || $(element).val().length > maxLength)
	{
		$(errorElement).slideDown().html("<span class='error'>should be minimum 3 and maximum 20 characters</span>");
		$(element).css("border","solid red 1px");
		return false;
	}
    else
    {
    	$(errorElement).slideUp();
        $(element).css("border","solid black 1px");
        return true;
    }
}

function imageValidation(element, errorElement, extension)
{
	if($.inArray(extension, ['jpg','jpeg']) == -1) {
    	$(errorElement).slideDown().html("<span class='error'>Invalid Image Type</span>");
        $(element).css("border","solid red 1px");
        return false;
	}
	else
    {
    	$(errorElement).slideUp();
        $(element).css("border","solid black 1px");
        return true;
    }
}