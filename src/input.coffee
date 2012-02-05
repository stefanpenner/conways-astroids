window.Input =
  run: ->
    $(document).bind 'keyup keydown', (e) ->
      e.preventDefault()
      code = e.keyCode
      Player.current.h = (code is 37) # left
      Player.current.j = (code is 38) # up
      Player.current.l = (code is 39) # right
      Player.current.k = (code is 40) # down
      Player.current.space = (code is 32) # space
      Component.all.mark.respondToInput(Player.current)

