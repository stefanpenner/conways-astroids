$ ->
  space = new Sprite('space','assets/space.jpg',
    height: 500
    width: 900
  )

  asteroidSprite = new Sprite('asteroid','assets/asteroid.png',
    height: 42.8
    width: 37
  )

  new Componant('asteroid',asteroidSprite,
    height: 42.8
    width: 37
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

  window.controller =
    run: ->
      $(document).bind 'keyup keydown', (e) ->
        e.preventDefault()
        code = e.keyCode
        Player.current.h = (code is 37) # left
        Player.current.j = (code is 38) # up
        Player.current.l = (code is 39) # right
        Player.current.k = (code is 40) # down
        Componant.all.mark.respondToInput(Player.current)



  Resources.ready ->
    graphics.run()
    controller.run()


