class Missile extends RadialComponent
  constructor: (options={})->
    defaults =
      dx: 3
      dy: 2
      x: 500
      bounce: true

    super $.extend(true,defaults,options)

Missile.sprite = new Sprite('missile','assets/missile.png',
  height: 10
  width:  10
)
