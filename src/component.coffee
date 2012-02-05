class window.Component
  constructor: (@sprite,@options={}) ->
    @sprite = @sprite
    @x = @options.x || 0
    @y = @options.y || 0
    @velocity = @options.v || [0, 0]
    @orientation = @options.r || -(Math.PI)/2.0 # face your ass downwards
    @max_speed = @options.max_speed || 10
    @thrust_force = @options.thrust_force || 0.4
    @turn_rate = @options.turn_rate || Math.PI/20 # 20 key presses, positions

    # non-radial component control
    @dx = @options.dx || 0
    @dy = @options.dy || 0

    Component.all.push @

  speed: -> Math.sqrt(Math.pow(@velocity[0], 2) + Math.pow(@velocity[1], 2))

  respondToInput: (input) ->
    @input = input
    if @options.radial

      @thrust(@thrust_force) if input.up
      @thrust(-@thrust_force) if input.down

      @orientation += -@turn_rate if input.left
      @orientation +=  @turn_rate if input.right

    else
      @dx += -0.4 if input.left
      @dy += -0.4 if input.down
      @dy +=  0.4 if input.up
      @dx +=  0.4 if input.right

    # shoot missile
    if input.space
      missile = new Missile()
      # adjust center to be center of missile sprite on the player sprite -- TWO centers!
      center = [@x+@sprite.width/2-missile.sprite.width/2, @y+@sprite.height/2-missile.sprite.height/2]
      radius = @sprite.height/2
      x = Math.sin(-@orientation+Math.PI/2) * radius + center[0]
      y = Math.cos(-@orientation+Math.PI/2) * radius + center[1]
      missile.move(x, y).rotate(@orientation).thrust(5)
      graphics.ordered.push(missile)

    if input.r
      # debug reset to center
      @x = 450
      @y = 250
      @stop()

  thrust: (force) ->
    if @speed() > @max_speed
      # WARP DRIVE, ENGAGE
      # also, this breaks if you're going backwards
      @velocity[0] += @max_speed * Math.cos(@orientation)
      @velocity[1] += @max_speed * Math.sin(@orientation)
    else
      @velocity[0] += force * Math.cos(@orientation)
      @velocity[1] += force * Math.sin(@orientation)

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
      @x += @velocity[0]
      @y += @velocity[1]

    else
      @x += @dx
      @y += @dy

    #in bounds stuff
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
  stop: ->
    @v = 0
    @velocity[0] = 0
    @velocity[1] = 0

Component.all = []
