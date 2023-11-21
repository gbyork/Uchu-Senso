extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)
@onready var timer = $Timer
@onready var positions = $Positions
var enemy_scene = preload("res://Scenes/enemy.tscn")
var path_enemy_scene = preload("res://Scenes/pathenemy.tscn")
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


func _on_path_enemy_timer_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)





