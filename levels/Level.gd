extends Node

onready var coins = $Coins

var Collectible = preload('res://objects/Collectible.tscn')
var score = 0

func _ready():
	coins.hide()
	spawn_coins()
	$Player.start($PlayerSpawn.position)

func spawn_coins():
	var coin_count = 0
	for cell in coins.get_used_cells():
		var id = coins.get_cellv(cell)
		var type = coins.tile_set.tile_get_name(id)
		if type == 'Coin':
			var c = Collectible.instance()
			var pos = coins.map_to_world(cell)
			c.init(pos + coins.cell_size/2)
			add_child(c)
			c.connect('pickup', self, '_on_Collectible_pickup')
			coin_count += 1
	print(coin_count)

func _on_Collectible_pickup():
	score += 1
	print(score)