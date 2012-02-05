class Asteroid extends Component
  constructor: (@options={})->
    super(Asteroid.sprite,@options)

Asteroid.sprite = new Sprite('asteroid','assets/asteroid.png',
  height: 42.8
  width: 37
)
