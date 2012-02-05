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
    parent = arguments.callee
    webkitRequestAnimationFrame ->
      graphics.draw()
      parent()
