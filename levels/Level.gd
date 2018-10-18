extends Node

onready var coins = $Coins

var Collectible = preload('res://objects/Collectible.tscn')

func _ready():
	coins.hide()
	spawn_coins()

func spawn_coins():
	for cell in coins.get_used_cells():
		var id = coins.get_cellv(cell)
		var type = coins.tile_set.tile_get_name(id)
		if type == 'Coin':
			var c = Collectible.instance()
			var pos = coins.map_to_world(cell)
			c.init(pos + coins.cell_size/2)
			add_child(c)
			c.connect('pickup', self, '_on_Collectible_pickup')