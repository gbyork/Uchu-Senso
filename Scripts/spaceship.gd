extends CharacterBody2D

var speed = 200

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("moveUp"):
		velocity.y = -speed
	elif Input.is_action_pressed("moveDown"):
		velocity.y = speed
	if Input.is_action_pressed("moveLeft"):
		velocity.x = -speed
	elif Input.is_action_pressed("moveRight"):
		velocity.x = speed

	var new_position = global_position + velocity * delta
	var screensize = get_viewport_rect().size
	var spaceship_size = Vector2(32, 64)  # Adjust dimensions based on your spaceship
	new_position = new_position.clamp(Vector2(55, 0), screensize - spaceship_size)
	global_position = new_position

	move_and_slide()