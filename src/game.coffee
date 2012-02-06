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
    new Asteroid({
      x: 300
      y: 100
      bounce: true
    })
    new Asteroid({
      x: 100
      y: 300
      bounce: true
    })

    new Asteroid({
      x: 3
      y: 100
      bounce: true
    })
    new Asteroid({
      x: 800
      y: 100
      bounce: true
    })
  ]

  $('#robot').click ->
    graphics.ordered.push(new Asteroid({
      x:10
      y:420
      dx:10
      dy:-10
      bounce: true
    }))
  Resources.ready ->
    Runtime.run()
    graphics.run()
    Input.run()
