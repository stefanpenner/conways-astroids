window.Runtime =
  run: ->
    Component.all.mark.respondToInput(Input.state)
    component.tick() for component in Component.all
    setTimeout(arguments.callee,40)
