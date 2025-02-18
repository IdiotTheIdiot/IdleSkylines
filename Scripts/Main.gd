class_name Game 
extends Node2D

static var ref : Game


func _on_buy_buildings_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/BuyBuildingsMenu.tscn")

#Singleton Setup
func _init() -> void :
	if not ref : ref = self
	else : queue_free()

var data : Data = Data.new()

#Update Labels Functions
func update_label() -> void:
	(get_node("ColorRect/MarginContainer/GridContainer/PearlsAmountLabel") as Label).text = str(data.resources.Pearls) 


#debug Buttons setup

func _on_pearls_butt_pressed():
	data.resources.Pearls += 5
	update_label()

func _on_power_butt_pressed():
	pass # Replace with function body.

func _on_people_butt_pressed():
	pass # Replace with function body.
