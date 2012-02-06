class Asteroid extends Component
  constructor: (options={})->
    super($.extend(true,{
      dx: Math.random() * 10 - 5
      dy: Math.random() * 10 -5
      bounce: -1
    },options))

Asteroid.sprite = new Sprite('asteroid','assets/asteroid.png',
  height: 42.8
  width: 37
)
