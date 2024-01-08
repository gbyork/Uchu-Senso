extends Node2D
@onready var EnemyEraser = $EnemyEraser
@onready var hud = $UI/HUD
@onready var ui = $UI
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_take_damage_sound = $PlayerTakeDamageSound
@onready var main_menu = $CanvasLayer/MainMenu/MenuPanel
@onready var address_entry = $CanvasLayer/MainMenu/MenuPanel/VBoxContainer/AddressEntry

const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()
var gos_scene = preload("res://Scenes/game_over_screen.tscn")
var spaceship = preload("res://Scenes/spaceship.tscn")
var lives = 3
var score = 0

func _ready():
	EnemyEraser.connect("area_entered",area_entered)
	hud.set_score_label(score)
	hud.set_lives_left_label(lives)

func area_entered(area):
	area.queue_free()

func _on_spaceship_took_damage():
	lives -= 1
	hud.set_lives_left_label(lives)
	player_take_damage_sound.play()
	if (lives == 0):
		print("Game Over")
		spaceship.die()
		await get_tree().create_timer(1).timeout
		var gos = gos_scene.instantiate()
		gos.set_score(score)
		ui.add_child(gos)

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child.call_deferred(enemy_instance)

func _on_enemy_died():
	score += 100
	enemy_hit_sound.play()
	hud.set_score_label(score)


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
	


func _on_host_button_pressed():
	main_menu.hide()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	add_player(multiplayer.get_unique_id())
	
func _on_join_button_pressed():
	main_menu.hide()
	
	enet_peer.create_client("localhost",PORT)
	multiplayer.multiplayer_peer = enet_peer
	
func add_player(peer_id):
	var spaceship = spaceship.instantiate()
	spaceship.name = str(peer_id)
	add_child(spaceship)

