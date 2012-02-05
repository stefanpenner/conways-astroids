$ ->
  space = new Sprite('space','assets/space.jpg',
    height: 500
    width: 900
  )


  window.Missile = Missile
  window.Ship = Ship
  window.Asteroid = Asteroid

  Player.current = new Player("stefan")

  canvas = $('#game')[0]
  window.graphics = new Graphics(canvas, { x:0,y:0 } )
  window.logic    = Logic

  Component.all.mark = new Ship()

  window.graphics.ordered = [
    Sprite.find.space
    Component.all.mark
    new Asteroid()
    new Asteroid()
    new Asteroid()
    new Missile()
  ]

  window.controller =
    run: ->
      $(document).bind 'keyup keydown', (e) ->
        e.preventDefault()
        code = e.keyCode
        Player.current.h = (code is 37) # left
        Player.current.j = (code is 38) # up
        Player.current.l = (code is 39) # right
        Player.current.k = (code is 40) # down
        Player.current.space = (code is 32) # space
        Component.all.mark.respondToInput(Player.current)

  Resources.ready ->
    logic.run()
    graphics.run()
    controller.run()
