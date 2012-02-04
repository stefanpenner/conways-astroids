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
    ctx.drawImage(@image[0],x,y,height || @height, width || @width)
    @

Sprite.all = {}
class window.Component
  constructor: (x,y,sprite) ->

class window.Gameboard
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @background = Sprite.all.background
    @mark       = Sprite.all.mark

  clear: -> @ctx.clearRect(0,0,800,500)

  draw: ->
    @clear()
    @background.draw(@ctx,0,0)
    @mark.draw(@ctx,0,0)
    @

  draw2: ->
    @clear()
    @mark.draw(@ctx,10,10)

$ ->
  new Sprite('background','assets/bg.jpg')
  new Sprite('mark','assets/mark.jpg')

  canvas = $('#game')[0]
  window.game = new Gameboard(canvas)

  count = 0

  $('html').bind 'imageload', =>
    count += 1
    game.draw() if count == 2

  Sprite.all[sprite].preload() for sprite of Sprite.all

