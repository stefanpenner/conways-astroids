class Missile extends Component
  constructor: ->
    super(Missile.sprite,
      dx: 3
      dy: 2
      x: 500
      bounce: true
      radial: true
    )

Missile.sprite = new Sprite('missile','assets/missile.png',
  height: 10
  width:  10
)
