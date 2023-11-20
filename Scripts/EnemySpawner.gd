extends Node2D

signal enemy_spawned(enemy_instance)
@onready var timer = $Timer
@onready var positions = $Positions
var enemy_scene = preload("res://Scenes/enemy.tscn")
@onready var enemy_container = get_node("EnemyContainer")

func _ready():
	timer.connect("timeout",spawn_enemy)
	spawn_enemy()

func spawn_enemy():
	
	var positions_array = positions.get_children()
	var randomize_positions = positions_array.pick_random()
	
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = randomize_positions.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#enemy_container.add_child(enemy_instance)
