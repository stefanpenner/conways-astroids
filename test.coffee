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
    ctx.drawImage(@image[0], x || 0, y || 0 ,width || @width, height || @height)
    @

Sprite.all = {}

class window.Player
  constructor: (@name) ->
    @name = "name"
    @h = false
    @j = false
    @k = false
    @l = false

class window.Componant
  constructor: (@name,@sprite,@options={}) ->
    @sprite = @sprite
    @x = @options.x || 0
    @y = @options.y || 0

    @deltaX = @options.deltaX || 0
    @deltaY = @options.deltaY || 0

    Componant.all[@name] = @

  respondToInput: (@user) ->
    @deltaX += -0.2 if @user.h
    @deltaY += -0.2 if @user.j
    @deltaY +=  0.2 if @user.k
    @deltaX +=  0.2 if @user.l

  draw: (@ctx) ->
    @x += @deltaX
    @y += @deltaY

    if @options.bounce
      @delta = -1
    else
      @delta = 0

    if @x > 800 - 40
      @deltaX = @deltaX * @delta
      @x = 800 - 40

    if @x < 0
      @deltaX = @deltaX * @delta
      @x = 0

    if @y > 500 - 140
      @deltaY = @deltaY * @delta
      @y = 500 - 140

    if @y < 0
      @deltaY = @deltaY * @delta
      @y = 0

    @sprite.draw(@ctx,@x,@y)

Componant.all = {}

class window.Gameboard
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @background = Sprite.all.space
    @mark       = Componant.all.mark

  clear: -> @ctx.clearRect(0,0,900,500)

  draw: ->
    @clear()
    @mark.respondToInput(Player.current)
    @background.draw(@ctx,0,0)
    @mark.draw(@ctx,0,0)
    @

  run: ->
    parent = arguments.callee
    webkitRequestAnimationFrame ->
      game.draw()
      parent()

$ ->
  space = new Sprite('space','assets/space.jpg')
  new Componant('mark',new Sprite('mark','assets/mark.jpg'),
    velocityX: 2
    velocityY: 3
    bounce: false
  )

  Player.current = new Player("stefan")

  canvas = $('#game')[0]
  window.game = new Gameboard(canvas, { x:0,y:0 } )

  count = 0

  $('html').bind 'imageload', =>
    count += 1
    game.run() if count == 2

  Sprite.all[sprite].preload() for sprite of Sprite.all

  $(document).bind 'keyup keydown', (e) ->
    code = e.keyCode
    console.log(e,code)
    Player.current.h = code is 37 # left
    Player.current.j = code is 38 # up
    Player.current.l = code is 39 # right
    Player.current.k = code is 40 # down
