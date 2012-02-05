class Ship extends Component
  constructor: ->
    super(Ship.sprite,
      x: 300
      y: 300
      radial: true
    )

Ship.sprite = new Sprite('Ship','assets/ship.png',
  height: 50
  width:  50
)
