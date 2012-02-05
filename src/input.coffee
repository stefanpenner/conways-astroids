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
    82: 'r'

  run: ->
    $(document).keyup (e) ->
      code = Input.humanize[e.keyCode]
      Input.state[code] = false
      e.preventDefault()
      return false

    $(document).keydown (e) ->
      code = Input.humanize[e.keyCode]
      Input.state[code] = true
      e.preventDefault()
      return false
