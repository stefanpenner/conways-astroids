window.Resources =
  sprites: ->
    Sprite.all

  ready: (callback) ->
    sprites = Sprite.all
    count = 0
    expected = Object.keys(sprites).length
    $('html').bind 'sprite.loaded', =>
      count += 1
      callback() if count is expected

    sprite.preload() for key, sprite of sprites
