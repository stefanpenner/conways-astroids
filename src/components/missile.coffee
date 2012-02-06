class Missile extends RadialComponent
  constructor: ->
    super(
      dx: 3
      dy: 2
      x: 500
      bounce: -1
    )

Missile.sprite = new Sprite('missile','assets/missile.png',
  height: 10
  width:  10
)
