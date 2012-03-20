toggle_edit_list = () ->
  $('.fact_list .delete').toggle()
  $('.standard_title.list').toggle()
  $('.edit_list_form').toggle()
  $('.position').toggle()
  $('.handle').toggle()
  $('.edit_list_button').toggleClass('down')
  $('.delete_list_button').toggleClass('down')


$ ->
  $('#facts').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      console.log("Sort UI call successful, moving to POST")
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

$ ->
  $('.new_fact_button').click (e) ->
    e.preventDefault()
    $('.add-fact-form').show()

$ ->
  $('.cancel_new_fact').click (e) ->
    e.preventDefault()
    $('.add-fact-form').hide()

$ ->
  $('.edit_list_button').click -> 
    toggle_edit_list()