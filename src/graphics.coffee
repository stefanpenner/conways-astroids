class window.Graphics
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @ordered = [
      Sprite.all.space
      Componant.all.mark
      Componant.all.asteroid
      Componant.all.asteroid2
      Componant.all.missile
    ]
  clear: -> @ctx.clearRect(0,0,900,500)

  draw: ->
    @clear()
    comp.draw(@ctx) for comp in @ordered
    @

  run: ->
    parent = arguments.callee
    webkitRequestAnimationFrame ->
      graphics.draw()
      parent()
