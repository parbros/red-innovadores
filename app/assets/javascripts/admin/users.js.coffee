# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.delete-selected-users').click (event) ->
  event.preventDefault
  $('form').attr('action', '/admin/users').attr('method', 'delete').submit()

$('.subscribe-selected-users').click (event) ->
  event.preventDefault
  $('form').attr('action', '/admin/users/bulk_subscribe_to_courses').submit()

