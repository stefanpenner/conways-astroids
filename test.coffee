class window.Sprite
  constructor: (@name,@src) ->
    @image = $(new Image())
    @loaded = false
    Sprite.all[@name] = @

  preload: ->
    @image.load( =>
      image = @image[0]
      @height = image.height
      @width  = image.width
      $('html').trigger('imageload', @name)
    ).attr('src',@src)

  draw: (ctx,x,y,height,width) ->
    ctx.drawImage(@image[0],x,y,width || @width, height || @height)
    @

Sprite.all = {}

class window.Componant
  constructor: (@name,@options)
    @sprite = @options.sprite
    @x = @options.x
    @y = @options.y

class window.Gameboard
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @background = Sprite.all.space
    @mark       = Sprite.all.mark

  clear: -> @ctx.clearRect(0,0,900,500)

  draw: ->
    @clear()
    @background.draw(@ctx,0,0)
    @mark.draw(@ctx,0,0)
    console.log('draw')
    @

  run: ->
    parent = arguments.callee
    webkitRequestAnimationFrame ->
      game.draw()
      parent()

$ ->
  new Sprite('space','assets/space.jpg')
  new Sprite('mark','assets/mark.jpg')

  canvas = $('#game')[0]
  window.game = new Gameboard(canvas)

  count = 0

  $('html').bind 'imageload', =>
    count += 1
    game.run() if count == 2

  Sprite.all[sprite].preload() for sprite of Sprite.all

