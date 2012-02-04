window.Resources =
  sprites: []
  css: []
  files: []
  sounds: []
  callbacks: []
  ready: (callback) ->
    count = 0
    $('html').bind 'imageload', =>
      count += 1
      callback() if count is 3

    Sprite.all[sprite].preload() for sprite of Sprite.all
