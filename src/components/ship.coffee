class Ship extends Component
  constructor: ->
    super(Ship.sprite,
      x: 100
      y: 100
      radial: true
    )
Ship.sprite = new Sprite('Mark','assets/mark.jpg')
