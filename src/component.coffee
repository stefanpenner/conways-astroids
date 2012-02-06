class window.Component
  constructor: (@options={}) ->
    @sprite = @constructor.sprite || @options.sprite

    @x = @options.x || 0
    @y = @options.y || 0

    @dx = @options.dx || 0
    @dy = @options.dy || 0

    @bounce = @options.bounce || 0

    @maxSpeed    = @options.maxSpeed    || 10
    @orientation = @options.orientation || -(Math.PI)/2.0 # face your ass downwards

    Component.all.push @

  speed: -> Math.sqrt(Math.pow(@dx, 2) + Math.pow(@dy, 2))

  respondToInput: (input) ->
    @dx += -0.4 if input.left
    @dy += -0.4 if input.down
    @dy +=  0.4 if input.up
    @dx +=  0.4 if input.right

  height: -> @options.height || @sprite.height
  width:  -> @options.width  || @sprite.width

  tick: ->
    height = @height()
    width  = @width()

    @x += @dx
    @y += @dy

    #right wall
    if @x > 900 - width
      @dx = @dx * @bounce
      @x = 900 - width

    #left wall
    if @x < 0
      @dx = @dx * @bounce
      @x = 0

    #bottom wall
    if @y > 500 - height
      @dy = @dy * @bounce
      @y = 500 - height

    #top wall
    if @y < 0
      @dy = @dy * @bounce
      @y = 0

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
  stop: -> @dx = @dy= 0

Component.all = []

class window.RadialComponent extends Component
  constructor: (@options={}) ->
    super(@options)
    @thrustForce = @options.thrustForce || 0.4
    @turnRate    = @options.turnRate    || Math.PI/20 # 20 key presses, positions

  thrust: (force) ->
    if @speed() > @maxSpeed
      # WARP DRIVE, ENGAGE
      # also, this breaks if you're going backwards
      @dx += @maxSpeed * Math.cos(@orientation)
      @dy += @maxSpeed * Math.sin(@orientation)
    else
      @dx += force * Math.cos(@orientation)
      @dy += force * Math.sin(@orientation)

  respondToInput: (input) ->
    @thrust(@thrustForce)  if input.up
    @thrust(-@thrustForce) if input.down

    @orientation += -@turnRate if input.left
    @orientation +=  @turnRate if input.right
