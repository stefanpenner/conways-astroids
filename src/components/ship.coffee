class Ship extends Component
  constructor: ->
    super(
      x: 300
      y: 300
      radial: true
    )

  respondToInput: (input) ->
    if input.space
      missile = new Missile()
      # adjust center to be center of missile sprite on the player sprite -- TWO centers!
      center = [@x+@sprite.width/2-missile.sprite.width/2, @y+@sprite.height/2-missile.sprite.height/2]
      radius = @sprite.height/2
      x = Math.sin(-@orientation+Math.PI/2) * radius + center[0]
      y = Math.cos(-@orientation+Math.PI/2) * radius + center[1]
      missile.move(x, y).rotate(@orientation).thrust(5)
      graphics.ordered.push(missile)

    super(input)

Ship.sprite = new Sprite('Ship','assets/ship.png',
  height: 50
  width:  50
)
