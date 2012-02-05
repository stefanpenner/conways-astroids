window.Input =
  state:
    reset: ->
      Input.state =
        reset: arguments.callee

  humanize:
    32: 'space'
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'

  run: ->
    $(document).bind 'keyup', (e) ->
      code = Input.humanize[e.keyCode]
      Input.state[code] = false

      Component.all.mark.respondToInput(Input.state)

    $(document).bind 'keydown', (e) ->
      code = Input.humanize[e.keyCode]
      Input.state[code] = true
      Component.all.mark.respondToInput(Input.state)