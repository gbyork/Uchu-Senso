extends CharacterBody2D

signal took_damage

var speed = 200
var blast_scene = preload("res://Scenes/blasters.tscn")
@onready var blaster_container = get_node("BlasterContainer")
@onready var blaster_sound = $BlasterSound

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return

func _process(delta):
	if not is_multiplayer_authority(): return
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _process_input():
	if not is_multiplayer_authority(): return
	velocity = Vector2()

	if Input.is_action_pressed("moveUp"):
		velocity.y = -speed
	elif Input.is_action_pressed("moveDown"):
		velocity.y = speed

	if Input.is_action_pressed("moveLeft"):
		velocity.x = -speed
	elif Input.is_action_pressed("moveRight"):
		velocity.x = speed

func _process_border(delta):
	var new_position = global_position + velocity * delta
	var screensize = get_viewport_rect().size
	var spaceship_size = Vector2(32, 64)  # Adjust dimensions based on your spaceship
	new_position = new_position.clamp(Vector2(55, 0), screensize - spaceship_size)
	global_position = new_position
	
func _physics_process(delta):
	_process_input()
	_process_border(delta)
	move_and_slide()

func shoot():
	var blaster_instance = blast_scene.instantiate()
	blaster_container.add_child(blaster_instance)
	blaster_sound.play()
	blaster_instance.global_position = global_position
	blaster_instance.global_position.y += 28

func take_damage():
	emit_signal("took_damage")

func die():
	queue_free()


