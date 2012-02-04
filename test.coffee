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

  draw: (ctx,x=0,y=0,height=@height,width=@width,r) ->
    pivotX = x + (width/2)
    pivotY = y + (height/2)
    ctx.save()
    ctx.translate(pivotX, pivotY)
    ctx.rotate((r)*3.14)
    ctx.drawImage(@image[0], -(width/2), -(height/2), width, height)
    ctx.translate(-pivotX, -pivotY)
    ctx.restore()
    @

Sprite.all = {}

class window.Player
  constructor: (@name) ->
  hasResponsedToInput: -> @h = @j = @k = @l = null

class window.Componant
  constructor: (@name,@sprite,@options={}) ->
    @sprite = @sprite
    @x = @options.x || 0
    @y = @options.y || 0
    @r = 0
    @v = @options.v || 0

    @height = @options.height || @sprite.height
    @width  = @options.width  || @sprite.width

    @deltaX = @options.deltaX || 0
    @deltaY = @options.deltaY || 0

    Componant.all[@name] = @

  respondToInput: (@user) ->

    if @options.radial
      @v += -0.4 if @user.j
      @v +=  0.4 if @user.k

      @r += -0.02 if @user.h
      @r +=  0.02 if @user.l

    else
      @deltaX += -0.4 if @user.h
      @deltaY += -0.4 if @user.j
      @deltaY +=  0.4 if @user.k
      @deltaX +=  0.4 if @user.l

    @user.hasResponsedToInput()

  draw: (@ctx) ->
    @height = @height || @sprite.height
    @width  = @height || @sprite.width
    if @options.radial
      @x += @v * Math.cos((@r+(1/2))*3.14)
      @y += @v * Math.sin((@r+(1/2))*3.14)
    else
      @x += @deltaX
      @y += @deltaY

    if @options.bounce
      @delta = -1
    else
      @delta = 0

    #right
    if @x > 900 - @width
      @deltaX = @deltaX * @delta
      @x = 900 - @width
      @v = 0

    #left
    if @x < 0
      @deltaX = @deltaX * @delta
      @x = 0
      @v = 0

    #bottom
    if @y > 500 - @height
      @deltaY = @deltaY * @delta
      @y = 500 - @height
      @v = 0

    #top
    if @y < 0
      @deltaY = @deltaY * @delta
      @y = 0
      @v = 0

    @sprite.draw(@ctx,@x,@y,@height,@width,@r)

Componant.all = {}

class window.Gameboard
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @background = Sprite.all.space
    @mark       = Componant.all.mark
    @asteroid   = Componant.all.asteroid
    @asteroid2  = Componant.all.asteroid2

  clear: -> @ctx.clearRect(0,0,900,500)

  draw: ->
    @clear()
    # stuffToDraw.forEach (component) ->
    #   component.draw(ctx)
    @background.draw(@ctx)
    @mark.draw(@ctx)
    @asteroid.draw(@ctx)
    @asteroid2.draw(@ctx)

    @

  run: ->
    parent = arguments.callee
    webkitRequestAnimationFrame ->
      game.draw()
      parent()

$ ->
  space = new Sprite('space','assets/space.jpg')
  asteroidSprite = new Sprite('asteroid','assets/asteroid.png')

  new Componant('asteroid',asteroidSprite,
    height: 42.8
    width: 37
    bounce: true
    deltaX: 5
    deltaY: 5
  )

  new Componant('asteroid2',asteroidSprite,
    height: 42.8
    width: 37
    bounce: true
    deltaX: 3
    deltaY: 2
    x: 500
    y: 300
  )

  new Componant('mark',new Sprite('mark','assets/mark.jpg'),
    x: 100
    y: 100
    radial: true
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
    Player.current.h = (code == 37) # left
    Player.current.j = (code == 38) # up
    Player.current.l = (code == 39) # right
    Player.current.k = (code == 40) # down
    window.game.mark.respondToInput(Player.current)
