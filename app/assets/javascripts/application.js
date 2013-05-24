// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require tinymce-jquery
//= require community
//= require videojs_loader
//= require jquery.easyValidate
//= require jquery.highlight
//= require jquery.zclip.min

$('#crearIdeaButton').click(function(event) {
  event.preventDefault();
  $('form#new_idea').submit();
});

$('#crearExperienceButton').click(function(event) {
  event.preventDefault();
  $('form#new_experience').submit();
});

$('#mceAdvImage').click(function() {
  tinyMCE.activeEditor.execCommand('mceAdvImage');
});

$('#mceUploadImage').click(function() {
  tinyMCE.activeEditor.execCommand('mceUploadImage');
});

$('#mceMedia').click(function() {
  tinyMCE.activeEditor.execCommand('mceMedia');
});

$('#mcePreview').click(function() {
  tinyMCE.activeEditor.execCommand('mcePreview');
});

$('.show-comment-response').click(function(event) {
  event.preventDefault();
  var commentId = $(this).data('comment-id');
  $('#form-response-comment-' + commentId).toggle();
});

$('.comment-link').zclip({
    path: '/assets/ZeroClipboard.swf',
    clickAfter: false,
    afterCopy: function() {},
    copy: function(){
      return $(this).data('comment-link');
    }
});