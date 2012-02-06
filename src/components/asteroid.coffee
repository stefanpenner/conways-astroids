class Asteroid extends Component
  constructor: (options={})->
    defaults =
      dx: Math.random() * 10 - 5
      dy: Math.random() * 10 -5
      bounce: true

    super $.extend(true,defaults,options)

Asteroid.sprite = new Sprite('asteroid','assets/asteroid.png',
  height: 42.8
  width: 37
)
