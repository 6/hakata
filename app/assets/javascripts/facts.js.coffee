$ ->
  key_bindings = false

next_fact = () ->
  $('.key.right').addClass('pressed')
  window.location = $('.next').attr('href') if $('.next').is('*')
  
previous_fact = () ->
  $('.key.left').addClass('pressed')
  window.location = $('.previous').attr('href') if $('.previous').is('*')

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
  $('.fact_list .delete').toggle()
  $('.standard_title.list').toggle()
  $('.edit_list_form').toggle()
  $('.position').toggle()
  $('.handle').toggle()
  $('.edit_list_button').toggleClass('down')
  $('.delete_list_button').toggleClass('down')

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
      view: 'off'
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
  $('.up, .down').click ->
    $(this).next().submit()

# Key Bindings
# ============================================================= #

$ ->
  $('#turn_key_bindings_on').click -> 
    $.post '/facts/set_key_bindings',
      key_bindings: 'true'
      (data) ->
        $(this).hide()
        $('#key_bindings').show()
        $('#key_bindings').data('key-bindings', true)
    
$ ->
  $('#turn_key_bindings_off').click -> 
    $.post '/facts/set_key_bindings',
      key_bindings: 'false'
      (data) ->
        $('#turn_key_bindings_on').show()
        $('#key_bindings').hide()
        $('#key_bindings').data('key-bindings', false)

$ ->
  $('.key.right').click ->
    next_fact()

$ ->
  $('.key.left').click -> 
    previous_fact()

# The proceeding two may break in non-webkit browsers

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 37 && $('#key_bindings').data('key-bindings') == true
      previous_fact()
  );

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 39 && $('#key_bindings').data('key-bindings') == true
      next_fact()
  );

# Voting
# ============================================================= #

$ ->
  $('.up_vote').click -> 
    mnemonic_id = $(this).data('mnemonic-id') 
    console.log(mnemonic_id) 
    $.post '/votes',
      monkey: 'orangutan'
      up: true
      mnemonic_id: mnemonic_id
      (data) ->
        console.log(data.id)
        $('.reverse_up').data('vote-id', data.id)
        $('.reverse_up').show()        
        $('.up_vote, .down_vote').hide()
        # this needs to be localized
        $('.score').html((Number) $('.score').html()- -1) 
        
$ ->
  $('.down_vote').click -> 
    mnemonic_id = $(this).data('mnemonic-id') 
    console.log(mnemonic_id) 
    $.post '/votes',
      monkey: 'orangutan'
      up: false
      mnemonic_id: mnemonic_id
      (data) ->
        console.log(data.id)
        $('.reverse_down').data('vote-id', data.id)
        $('.reverse_down').show()        
        $('.up_vote, .down_vote').hide()
        $('.score').html((Number) $('.score').html()-1)

$ -> 
  $('.reverse_up').click ->
    vote_id = $(this).data('vote-id')  
    $.ajax '/votes/'+vote_id,
      type: 'DELETE',
      success: (data) -> 
        $('.reverse_up, .reverse_down').hide()        
        $('.up_vote, .down_vote').show()
        $('.score').html((Number) $('.score').html()-1)

$ -> 
  $('.reverse_down').click ->
    vote_id = $(this).data('vote-id')  
    $.ajax '/votes/'+vote_id,
      type: 'DELETE',
      success: (data) -> 
        $('.reverse_up, .reverse_down').hide()        
        $('.up_vote, .down_vote').show()
        $('.score').html((Number) $('.score').html() - -1)

# This isn't even in Facts
# ========================================= #

$ ->
  $('.fact_list .delete').click (event) -> 
    event.preventDefault()
    fact_li = $(this).parent()
    $.post $(this).attr('href'),
      (data) -> fact_li.remove()



# $ ->
#   $(document).keydown( (e) ->
#     if e.keyCode == 37 ||
#        e.keyCode == 39
#       turn_center()
#   );
  
# Edit mode in list/show
# ================================= #

