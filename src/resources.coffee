window.Resources =
  sprites: ->
    Sprite.all
  ready: (callback) ->
    sprites = Sprite.all
    count = 0
    expected = Object.keys(sprites).length
    $('html').bind 'imageload', =>
      count += 1
      callback() if count is expected

    sprites[key].preload() for key of sprites
