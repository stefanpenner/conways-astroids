class window.Sprite
  constructor: (@name,@src,@options={}) ->
    @image = $(new Image())
    @loaded = false
    @x = @options.x || 0
    @y = @options.y || 0
    Sprite.find[@name] = @
    Sprite.all.push(@)

  preload: ->
    @image.load( =>
      image = @image[0]
      @height = @options.height || image.height
      @width  = @options.width  || image.width
      $('html').trigger('sprite.loaded', @name)
      @loaded = true
    ).attr('src',@src)

  place:(@x=0,@y=0) ->
    @

  rotate: (r) ->
    @r = r
    @

  resize: (height=@height,width=@width) ->
    @height=height
    @width=width
    @

  draw: (ctx) ->
    if @r
      pivotX = @x + (@width/2)
      pivotY = @y + (@height/2)
      ctx.save()
      ctx.translate(pivotX, pivotY)
      ctx.rotate(@r)
      ctx.drawImage(@image[0], -(@width/2), -(@height/2), @width, @height)
      ctx.translate(-pivotX, -pivotY)
      ctx.restore()
    else
      ctx.drawImage(@image[0], @x, @y, @width, @height)
    @

Sprite.all = []
Sprite.find = {}
