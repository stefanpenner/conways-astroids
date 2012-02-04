window.Logic =
  run: ->
    Componant.all[key].tick() for key of Componant.all
    setTimeout(arguments.callee,30)
