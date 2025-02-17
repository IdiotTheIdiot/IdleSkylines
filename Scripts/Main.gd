extends Node2D









func _on_buy_buildings_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/BuyBuildingsMenu.tscn")
