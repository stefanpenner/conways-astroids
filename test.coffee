class window.Sprite
  constructor: (@name,@src,@options={}) ->
    @image = $(new Image())
    @loaded = false
    @x = @options.x || 0
    @y = @options.y || 0
    Sprite.all[@name] = @

  preload: ->
    @image.load( =>
      image = @image[0]
      @height = @options.height || image.height
      @width  = @options.width  || image.width
      $('html').trigger('imageload', @name)
      @loaded = true
    ).attr('src',@src)

  place:(@x=0,@y=0) ->
    @

  rotate: (r) ->
    @r = r
    @

  resize: (height=@height,width=@width) ->
    @height=height
    @width=width
    @

  draw: (ctx) ->
    if @r
      pivotX = @x + (@width/2)
      pivotY = @y + (@height/2)
      ctx.save()
      ctx.translate(pivotX, pivotY)
      ctx.rotate((@r)*3.14)
      ctx.drawImage(@image[0], -(@width/2), -(@height/2), @width, @height)
      ctx.translate(-pivotX, -pivotY)
      ctx.restore()
    else
      ctx.drawImage(@image[0], @x, @y, @width, @height)
    @

Sprite.all = {}
window.ResourceManager =
  sprites: [],
  css: [],
  files: [],
  sounds: [],
  callbacks: []

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

    @dx = @options.dx || 0
    @dy = @options.dy || 0

    Componant.all[@name] = @

  respondToInput: (@user) ->

    if @options.radial
      @v += -0.4 if @user.j
      @v +=  0.4 if @user.k

      @r += -0.02 if @user.h
      @r +=  0.02 if @user.l

    else
      @dx += -0.4 if @user.h
      @dy += -0.4 if @user.j
      @dy +=  0.4 if @user.k
      @dx +=  0.4 if @user.l

    @user.hasResponsedToInput()

  draw: (@ctx) ->
    height = @sprite.height
    width = @sprite.width
    if @options.bounce
      @delta = -1
    else
      @delta = 0

    if @options.radial
      @x += @v * Math.cos((@r+(1/2))*3.14)
      @y += @v * Math.sin((@r+(1/2))*3.14)
    else
      @x += @dx
      @y += @dy

    #right
    if @x > 900 - width
      @dx = @dx * @delta
      @x = 900 - width
      @v = 0

    #left
    if @x < 0
      @dx = @dx * @delta
      @x = 0
      @v = 0

    #bottom
    if @y > 500 - height
      @dy = @dy * @delta
      @y = 500 - height
      @v = 0

    #top
    if @y < 0
      @dy = @dy * @delta
      @y = 0
      @v = 0

    @sprite.
      place(@x,@y).
      rotate(@r).
        draw(@ctx)
    @

  rotate: (r) ->
    @r = r
    @

  resize: (@height,@width) ->

Componant.all = {}

class window.Graphics
  constructor: (@canvas) ->
    @ctx = @canvas.getContext('2d')
    @ordered = [
      Sprite.all.space
      Componant.all.mark
      Componant.all.asteroid
      Componant.all.asteroid2
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
