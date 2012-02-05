class Asteroid extends Component
  constructor: ->
    super(Asteroid.sprite,
      bounce: true
      dx: 5
      dy: 5
    )

Asteroid.sprite = new Sprite('asteroid','assets/asteroid.png',
  height: 42.8
  width: 37
)
