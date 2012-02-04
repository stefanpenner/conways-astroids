$ ->
  space = new Sprite('space','assets/space.jpg',
    height: 500
    width: 900
  )

  missile = new Sprite('missile','assets/missile.png')

  asteroidSprite = new Sprite('asteroid','assets/asteroid.png',
    height: 42.8
    width: 37
  )

  new Componant('missile', missile,
    dx: 10
    dy: 5
    x: 500
    bounce: true
    height: 10
    width:  10
  )

  new Componant('asteroid', asteroidSprite,
    bounce: true
    dx: 5
    dy: 5
  )

  new Componant('asteroid2',asteroidSprite,
    bounce: true
    dx: 3
    dy: 2
    x: 500
    y: 300
  )

  new Componant('mark',new Sprite('mark','assets/mark.jpg'),
    x: 100
    y: 100
    radial: true
  )

  Player.current = new Player("stefan")

  canvas = $('#game')[0]
  window.graphics = new Graphics(canvas, { x:0,y:0 } )
  window.logic    = Logic

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
        Componant.all.mark.respondToInput(Player.current)

  Resources.ready ->
    logic.run()
    graphics.run()
    controller.run()


