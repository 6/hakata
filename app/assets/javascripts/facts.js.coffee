mode_front = () ->
  $('#front_mode').addClass('front_pressed')
  $('#center_mode').removeClass('center_pressed')
  $('#back_mode').removeClass('back_pressed')
  turn_front()

turn_front = () ->
  $('#back').hide()
  $('#front').show()
  $('#center').hide()

mode_center = () ->
  $('#back_mode').removeClass('back_pressed')
  $('#center_mode').addClass('center_pressed')
  $('#front_mode').removeClass('front_pressed')
  turn_center()

turn_center = () ->
  $('#front').hide()
  $('#center').show()
  $('#back').hide()
  
mode_back = () ->
  $('#front_mode').removeClass('front_pressed')
  $('#center_mode').removeClass('center_pressed')
  $('#back_mode').addClass('back_pressed')
  turn_back()

turn_back = () ->
  $('#back').show()
  $('#front').hide()
  $('#center').hide()

toggle_edit_list = () ->
  $('.fact_list .delete').toggle(200)
  $('.standard_title.list').toggle(200)
  $('.edit_list_form').toggle(200)
  $('.edit_list_button').toggleClass('down')
  

# Le bindings
# ================================= #

$ ->
  $('#front_mode').click -> 
    $.post '/sessions/cardview',
      view: 'front'
      (data) -> mode_front()

$ ->
  $('#center_mode').click -> 
    $.post '/sessions/cardview',
      view: 'center'
      (data) -> mode_center()
      
$ ->
  $('#back_mode').click -> 
    $.post '/sessions/cardview',
      view: 'back'
      (data) -> mode_back()

$ ->
  $('.return_to_center').click -> 
    turn_center()

$ ->
  $('.return_to_center').click -> 
    turn_center()

$ ->
  $('.edit_list_button').click -> 
    toggle_edit_list()
    
$ ->
  $('.fact_list .delete, h1').click (event) -> 
    event.preventDefault()
    fact_li = $(this).parent()
    $.post $(this).attr('href'),
      (data) -> fact_li.remove()

# The proceeding two may break in non-webkit browsers

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 38 
      window.location = $('.previous').attr('href') if $('.previous').is('*')
  );

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 40
      window.location = $('.next').attr('href') if $('.next').is('*')
  );

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 37 ||
       e.keyCode == 39
      turn_center()
  );
  
# Edit mode in list/show
# ================================= #

