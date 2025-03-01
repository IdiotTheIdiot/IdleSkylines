extends Control

@onready var anim = %AnimationPlayer

func _ready():
	anim.play("StartGameSequence")



func _on_play_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	print("hi")
