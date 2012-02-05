window.Runtime =
  run: ->
    component.tick() for component in Component.all
    setTimeout(arguments.callee,30)
