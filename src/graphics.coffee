class window.Graphics
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @ordered = []

  clear: -> @ctx.clearRect(0,0,900,500)

  draw: ->
    @clear()
    comp.draw(@ctx) for comp in @ordered.filter((i) -> i);
    @

  run: ->
    graphics.draw()

    requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame
    if requestAnimationFrame
      requestAnimationFrame arguments.callee
    else
      setTimeout(arguments.callee,40)
