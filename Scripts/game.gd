extends Node2D
@onready var spaceship = $Spaceship
@onready var EnemyEraser = $EnemyEraser
var lives = 3

func _ready():
	EnemyEraser.connect("area_entered",area_entered)

func area_entered(area):
	area.die()


func _on_spaceship_took_damage():
	lives -= 1
	if (lives == 0):
		print("Game Over")
		spaceship.die()
