window.App = {}

class Sprite
  constructor: (@ctx,@src) ->
    @image = $(new Image())

  draw: (x,y,height,width) ->
    @image.load( =>
      image = @image[0]

      height = height or image.height
      width  = width  or image.width

      @ctx.drawImage(image,x,y,height,width)
    ).attr('src',@src)

class App.Gameboard
  constructor: (@ctx) ->
    @background = new Sprite(@ctx,'assets/bg.jpg')
    @background.draw(0,0)
    @background.draw(100,100,10,10)

  draw: ->
    @ctx.beginPath()
    @ctx.moveTo(200,0)
    @ctx.lineTo(200,600)
    @ctx.moveTo(400,0)
    @ctx.lineTo(400,600)
    @ctx.moveTo(0,200)
    @ctx.lineTo(600,200)
    @ctx.moveTo(0,400)
    @ctx.lineTo(600,400)
    @ctx.stroke()

  x: ->
    @ctx.lineWidth = 2
    @ctx.beginPath()
    @ctx.moveTo(10,10)
    @ctx.lineTo(190,190)
    @ctx.moveTo(190,10)
    @ctx.lineTo(10,190)
    @ctx.stroke()



$ ->
  canvas = $('#game')[0]
  context = canvas.getContext('2d')

  App.game = new App.Gameboard(context)
  App.game.draw()

