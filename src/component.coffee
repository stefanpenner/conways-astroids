class window.Componant
  constructor: (@name,@sprite,@options={}) ->
    @sprite = @sprite
    @x = @options.x || 0
    @y = @options.y || 0
    @v = @options.v || 0
    @r = @options.r || 0

    @dx = @options.dx || 0
    @dy = @options.dy || 0

    Componant.all[@name] = @

  respondToInput: (input) ->

    if @options.radial
      @v += -0.4 if input.j
      @v +=  0.4 if input.k

      @r += -0.02 if input.h
      @r +=  0.02 if input.l

    else
      @dx += -0.4 if input.h
      @dy += -0.4 if input.j
      @dy +=  0.4 if input.k
      @dx +=  0.4 if input.l

    input.reset()

  height: -> @options.height || @sprite.height
  width:  -> @options.width  || @sprite.width

  tick: ->
    height = @height()
    width  = @width()

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


  draw: (@ctx) ->
    @sprite.
      place(@x,@y).
      rotate(@r).
      resize(@height(),@width()).
        draw(@ctx)
    @

  rotate: (r) ->
    @r = r
    @

  resize: (@height,@width) ->

Componant.all = {}
