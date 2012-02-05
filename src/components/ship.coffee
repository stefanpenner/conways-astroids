class Ship extends Component
  constructor: ->
    super(Ship.sprite,
      x: 100
      y: 100
      radial: true
    )

Ship.sprite = new Sprite('Ship','assets/ship.png',
  height: 50
  width:  50
)
