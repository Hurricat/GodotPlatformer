extends Node

onready var coins = $Coins
onready var enemies = $Enemies

var Collectible = preload('res://objects/Collectible.tscn')
var Enemy = {'Goomba': preload('res://enemies/Goomba.tscn')}
var score = 0

func _ready():
	coins.hide()
	enemies.hide()
	spawn_coins()
	spawn_enemies()
	$Player.start($PlayerSpawn.position)

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

func spawn_enemies():
	for cell in enemies.get_used_cells():
		var id = enemies.get_cellv(cell)
		var type = enemies.tile_set.tile_get_name(id)
		if type in Enemy.keys():
			var c = Enemy[type].instance()
			var pos = enemies.map_to_world(cell)
			pos.x = pos.x + enemies.cell_size.x/2
			pos.y = pos.y + enemies.cell_size.y
			c.init(pos)
			add_child(c)

func _on_Collectible_pickup():
	score += 1