extends Control

@onready var score = $score
@onready var lives_left = $LivesLeft

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_lives_left_label(new_lives_count):
	lives_left.text = str(new_lives_count)

