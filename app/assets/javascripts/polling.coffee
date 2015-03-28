window.Poll = ->
  setTimeout ->
    $.get('/gchats')
  , 5000
 
jQuery ->
  Poll() if $('#gchats').size() > 0
