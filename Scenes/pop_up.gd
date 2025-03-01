class_name Popip
extends ColorRect

static var ref : Popip

func _init() -> void :
	if not ref : ref = self
	else : queue_free()

@onready var PopLabel : Label = get_node("VBoxContainer/MarginContainer/PopUpLabel")

func set_text(text : String):
	PopLabel.text = text

func reveal_button() -> void:
	get_node("VBoxContainer/Button").show()

func hide_button() -> void:
	get_node("VBoxContainer/Button").hide()
	


func _on_button_pressed():
	ResourcesManager.ref.finish_tutorial()
	get_node(".").hide()
