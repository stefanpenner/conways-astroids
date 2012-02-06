class Ship extends RadialComponent
  constructor: (options={}) ->
    defaults =
      x: 300
      y: 300
      radial: true

    super $.extend(true,defaults,options)

  respondToInput: (input) ->
    if input.space
      missile = new Missile()
      # adjust center to be center of missile sprite on the player sprite -- TWO centers!
      #
      centerX = @x + @sprite.width  / 2 - missile.sprite.width  / 2
      centerY = @y + @sprite.height / 2 - missile.sprite.height / 2

      radius = @sprite.height/2
      theta  = -@orientation + Math.PI/2

      x = Math.sin(theta) * radius + centerX
      y = Math.cos(theta) * radius + centerY

      missile.move(x, y).rotate(@orientation).thrust(5)

      graphics.ordered.push(missile)

    super input

Ship.sprite = new Sprite('Ship','assets/ship.png',
  height: 50
  width:  50
)
