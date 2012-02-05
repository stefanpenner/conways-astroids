$ ->
  space = new Sprite('space','assets/space.jpg',
    height: 500
    width: 900
  )

  window.Ship = Ship
  window.Missile = Missile
  window.Asteroid = Asteroid

  Player.current = new Player("stefan")

  canvas = $('#game')[0]
  window.graphics = new Graphics(canvas, { x:0,y:0 } )

  Component.all.mark = new Ship()

  window.graphics.ordered = [
    Sprite.find.space
    Component.all.mark
    new Asteroid()
    new Missile()
  ]

  Resources.ready ->
    Runtime.run()
    graphics.run()
    Input.run()
