class Asteroid extends Component
  constructor: (options={})->
    # random direction by default
    options.dx ?= Math.random() * 10 - 5
    options.dy ?= Math.random() * 10 - 5
    options.bounce = -1

    super(options)

Asteroid.sprite = new Sprite('asteroid','assets/asteroid.png',
  height: 42.8
  width: 37
)
