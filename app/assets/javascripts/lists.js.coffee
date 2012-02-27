# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#facts').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      console.log("Sort UI call successful, moving to POST")
      $.post($(this).data('update-url'), $(this).sortable('serialize'))