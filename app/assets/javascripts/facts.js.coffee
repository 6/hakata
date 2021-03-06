$ ->
  key_bindings = false

next_fact = () ->
  $('.key.right').addClass('pressed')
  window.location = $('.next a').attr('href')
  
previous_fact = () ->
  $('.key.left').addClass('pressed')
  window.location = $('.previous a').attr('href')

mode_front = () ->
  $('#card_mode').data('card-mode', 'front')
  $('#front_mode').addClass('front_pressed')
  $('#center_mode').removeClass('center_pressed')
  $('#back_mode').removeClass('back_pressed')
  $('.key.shift').removeClass('disabled')
  $('#list_navigation .name').show()
  $('#list_navigation .definition').hide()
  $('.key.shift').removeClass('pressed')
  turn_front()

turn_front = () ->
  $('#back').hide()
  $('#front').show()
  $('#center').hide()

mode_center = () ->
  $('#card_mode').data('card-mode', 'off')
  $('#back_mode').removeClass('back_pressed')
  $('#center_mode').addClass('center_pressed')
  $('#front_mode').removeClass('front_pressed')
  $('.key.shift').addClass('disabled')
  $('.key.shift').removeClass('pressed')
  $('#list_navigation .name').show()
  $('#list_navigation .definition').hide()
  turn_center()

turn_center = () ->
  $('#front').hide()
  $('#center').show()
  $('#back').hide()
  
mode_back = () ->
  $('#card_mode').data('card-mode', 'back')
  $('#front_mode').removeClass('front_pressed')
  $('#center_mode').removeClass('center_pressed')
  $('#back_mode').addClass('back_pressed')
  $('.key.shift').removeClass('disabled')
  $('#list_navigation .name').hide()
  $('#list_navigation .definition').show()
  $('.key.shift').removeClass('pressed')
  turn_back()

turn_back = () ->
  $('#back').show()
  $('#front').hide()
  $('#center').hide()

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
  $('.up, .down').click ->
    $(this).next().submit()

# Key Bindings
# ============================================================= #

$ ->
  $('#turn_key_bindings_on').click -> 
    $.post '/facts/set_key_bindings',
      key_bindings: 'true'
      (data) ->
        $('#turn_key_bindings_on').hide()
        $('#turn_key_bindings_off').show()
        $('#key_bindings').show()
        $('#key_bindings').data('key-bindings', true)
    
$ ->
  $('#turn_key_bindings_off').click -> 
    $.post '/facts/set_key_bindings',
      key_bindings: 'false'
      (data) ->
        $('#turn_key_bindings_on').show()
        $('#turn_key_bindings_off').hide()
        $('#key_bindings').hide()
        $('#key_bindings').data('key-bindings', false)

$ ->
  $('.key.right, .key.left').hover ->
    $(this).toggleClass('hovering')

$ ->
  $('.key.right').click ->
    next_fact() if $('#next_fact').is('*')

$ ->
  $('.key.left').click -> 
    previous_fact() if $('.#previous_fact').is('*')

# The proceeding two may break in non-webkit browsers

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 37 && $('#key_bindings').data('key-bindings') && !$('textarea').is(":focus")
      previous_fact() if $('#previous_fact').is('*')
  );

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 39 && $('#key_bindings').data('key-bindings') && !$('textarea').is(":focus")
      next_fact() if $('#next_fact').is('*')
  );

$ ->
  $(document).keydown( (e) ->
    if e.keyCode == 16 && $('#key_bindings').data('key-bindings') && !$('textarea').is(":focus") && $('#card_mode').data('card-mode') != 'off'
      $('.key.shift').addClass('pressed')
      turn_center()
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

