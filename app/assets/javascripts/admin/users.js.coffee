# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('td.user_check_box').click (event) ->
  event.preventDefault();
  checkbox = $($(@).find('input'))
  isChecked = !checkbox.is(':checked');
  checkbox.attr('checked', isChecked);
