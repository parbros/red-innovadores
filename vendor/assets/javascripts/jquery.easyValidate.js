// ==ClosureCompiler==
// @output_file_name default.js
// @compilation_level SIMPLE_OPTIMIZATIONS
// ==/ClosureCompiler==

/*
 * easyValidate, a form validation jquery plugin
 * By Alex Gill, www.alexpetergill.com
 * Version 1.2
 * Copyright 2011 APGDESIGN
 * Updated 19/01/2013
 * Free to use under the MIT License
 * http://www.opensource.org/licenses/mit-license.php
*/
(function($) {
		  
	// DEFINE METHOD
	$.fn.easyValidate = function(settings){
	
		// DEFAULT OPTIONS
		var config = {
			promptPosition : 'topRight',
			ajaxSubmit : false,
			ajaxSubmitFile: ""
		};
		
		// EXTEND OPTIONS
		var settings = $.extend(config, settings);
		
		return this.each(function(){
			
			// SET VARIABLES
			var promptText = "";
			var isError = false;
			var button;
			var form = $(this).find('form');
      console.log(form);
			
			// IF AJAX, BUILD AJAX PROMPTS
			if( settings.ajaxSubmit ){
				_buildAjaxPrompts();
				var ajaxError = $('.ajaxError');
				var ajaxSuccess = $('.ajaxSuccess');
				var ajaxLoading = $('.ajaxLoading');
			}
			
			// GET ALL FORM ELEMENTS
			var elements = $(this).find('input, textarea, radio, checkbox, select');	
			elements.each(function(){
				if( $(this).attr('type') == 'submit'){
					button = $(this);	
				}
			});									
			
			// BUTTON LISTENER
			button.click(function(e){
				if( _isValid(form) ){
					_formSubmit();
				}
				e.preventDefault();
			});
			
			// FOCUS LISTERNER
			elements.each(function(){
				$(this).bind('blur keyup change', function(){
					_getRules( $(this) );				  
				});									   
			});
			
			// GET RULES FROM CLASS NAME
			function _getRules(element){
				var rulesParsed = element.attr('class');
				if(rulesParsed){
					var rules = rulesParsed.split(' ');
					_validate(element, rules);
				}
			};
			
			// APPLY RULES TO EACH ELEMENT
			function _validate(element, rules){
				
				// RESET VALUES FOR EACH ELEMENT
				promptText = "";
				isError = false;
				
				// LOOP RULES FOR EACH ELEMENT
				for(var i=0; i<rules.length; i++){
					if(rules[i] == 'required'){
						_required(element);
					}
					if(rules[i] == 'email'){
						_email(element);	
					}
				}
		
				// BUILD PROMPT IF RULE FAILS
				if(isError) {
					_buildPrompt(element, promptText);
					_addErrorClasses(element);
				} else {
					_removePrompt(element);	
					_removeErrorClasses(element);					
				}
			};
			
			// RULE: REQUIRED FIELD
			function _required(element){
				if( ! element.val() || element.val() == 0 ){
					isError = true;
					promptText = promptText + 'Este campo es requerido <br />';
				}
			};
			
			// RULE: VALID EMAIL STRING REQUIRED
			function _email(element){
				var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
				if (!filter.test( element.val() )) {
					isError = true;
					promptText = promptText + 'Por favor, ingrese un email valido';
				}
			};
			
			// RETURNS FORM VALIDATION STATUS
			function _isValid(form) {
				var errorsFound = 0;
				elements.each(function(){
					var elementTagName = this.tagName;
					var elementType = $(this).attr('type');
					if( elementTagName == 'INPUT' && elementType == 'text' || elementTagName == 'TEXTAREA' || elementTagName == 'SELECT'){
						_getRules( $(this) );
						if (isError) {
							errorsFound++;
						}
					}
				});
				if (!errorsFound > 0) {
					return true;
				}
			};
			
			// BUILDS DYNAMIC ERROR PROMPT
			function _buildPrompt(element, prompText) {
				
				// REMOVE ALL EXISTING PROMPTS ON INIT
				_removePrompt(element);
				
				// CREATE ERROR WRAPPER
				var divFormError = $('<div></div>');
				$(divFormError).addClass('formError');
				$(divFormError).addClass( 'formError'+$(element).attr('id') );
				$(element).parent().append(divFormError);

				// CREATE ERROR CONTENT
				var formErrorContent = $('<div></div>');
				$(formErrorContent).addClass('formErrorContent');
				$(divFormError).append(formErrorContent);
				$(formErrorContent).html(promptText);
				
				// DEFINE LAYOUT WITH CSS
				$(divFormError).css({					
					opacity : 0
				});
				
				// SHOW PROMPT
				return $(divFormError).animate({
					opacity : 0.8
				});
				
			};
			
			// REMOVE PROMPT
			function _removePrompt(element){
				$('body').find( '.formError'+$(element).attr('id') ).remove();
			};
			
			// SUBMIT FORM
			function _formSubmit() {
				if( settings.ajaxSubmit ){
					
					ajaxLoading.ajaxStart(function(){
						$(this).show();						   
					});
					ajaxLoading.ajaxStop(function(){
						$(this).hide();						   
					});
					
					// SETUP AJAX
					$.ajax({
						type: 'POST',
						url: settings.ajaxSubmitFile,
						async: true,
						data : form.serialize(),
						success: function(data){
							ajaxSuccess.html(data).show();
							form.hide();
						},
						error : function(xhr){
							ajaxError.html('Status: ' + xhr.status).show();
						}
					});
					
				} else {
					$('form').submit();
				}
			};
			
			// BUILD AJAX PROMPTS
			function _buildAjaxPrompts() {

				var ajaxErrorDiv = $('<div></div>');
				ajaxErrorDiv.addClass('ajaxError');	
				form.after(ajaxErrorDiv);

				var ajaxSuccessDiv = $('<div></div>');
				ajaxSuccessDiv.addClass('ajaxSuccess');
				form.after(ajaxSuccessDiv);
				
				var ajaxLoadingDiv = $('<div>Loading...</div>');
				ajaxLoadingDiv.addClass('ajaxLoading');
				form.after(ajaxLoadingDiv);

			};

			// ADD ERROR CLASSES TO ELEMENTS
			function _addErrorClasses(element) {
				$(element).addClass('form-error').siblings().addClass('form-error');
			}

			// REMOVE ERROR CLASSES FROM ELEMENTS
			function _removeErrorClasses(element) {
				$(element).removeClass('form-error').siblings().removeClass('form-class');
				$(element).parent().find('span').removeClass('form-error'); //NOT SURE WHY THIS WASNT REMOVED WITH SIBLINGS()
			}
			
		});
		
	};	
			
})(jQuery);