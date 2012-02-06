class window.Component
  constructor: (@options={}) ->
    @sprite = @constructor.sprite || @options.sprite

    @x = @options.x || 0
    @y = @options.y || 0

    @velocity    = @options.velocity    || [0, 0]
    @orientation = @options.orientation || -(Math.PI)/2.0 # face your ass downwards
    @maxSpeed    = @options.maxSpeed    || 10
    @thrustForce = @options.thrustForce || 0.4
    @turnRate    = @options.turnRate    || Math.PI/20 # 20 key presses, positions

    # non-radial component control
    @dx = @options.dx || 0
    @dy = @options.dy || 0

    Component.all.push @

  speed: -> Math.sqrt(Math.pow(@velocity[0], 2) + Math.pow(@velocity[1], 2))

  respondToInput: (input) ->
    @input = input
    if @options.radial

      @thrust(@thrustForce)  if input.up
      @thrust(-@thrustForce) if input.down

      @orientation += -@turnRate if input.left
      @orientation +=  @turnRate if input.right

    else
      @dx += -0.4 if input.left
      @dy += -0.4 if input.down
      @dy +=  0.4 if input.up
      @dx +=  0.4 if input.right

    # shoot missile
    if input.orientation
      # debug reset to center
      @x = 450
      @y = 250
      @stop()

  thrust: (force) ->
    if @speed() > @maxSpeed
      # WARP DRIVE, ENGAGE
      # also, this breaks if you're going backwards
      @velocity[0] += @maxSpeed * Math.cos(@orientation)
      @velocity[1] += @maxSpeed * Math.sin(@orientation)
    else
      @velocity[0] += force * Math.cos(@orientation)
      @velocity[1] += force * Math.sin(@orientation)

  height: -> @options.height || @sprite.height
  width:  -> @options.width  || @sprite.width

  tick: ->
    height = @height()
    width  = @width()

    if @options.radial
      @x += @velocity[0]
      @y += @velocity[1]
    else
      @x += @dx
      @y += @dy

    #in bounds stuff
    if @options.bounce
      @delta = -1
    else
      @delta = 0

    #right wall
    if @x > 900 - width
      @dx = @dx * @delta
      @x = 900 - width
      @stop()

    #left wall
    if @x < 0
      @dx = @dx * @delta
      @x = 0
      @stop()

    #bottom wall
    if @y > 500 - height
      @dy = @dy * @delta
      @y = 500 - height
      @stop()

    #top wall
    if @y < 0
      @dy = @dy * @delta
      @y = 0
      @stop()

  draw: (@ctx) ->
    @sprite.
      place(@x,@y).
      rotate(@orientation+Math.PI/2).
      resize(@height(),@width()).
        draw(@ctx)
    @

  rotate: (@orientation) -> @
  move: (@x,@y) -> @
  resize: (@height,@width) ->
  stop: -> @velocity[0] = @velocity[1] = 0

Component.all = []
