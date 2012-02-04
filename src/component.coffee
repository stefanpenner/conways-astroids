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
