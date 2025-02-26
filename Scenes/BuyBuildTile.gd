class_name BuyBuildTile
extends Control


@export var Building_Type : int
@export var Building_Cost : int = 15


func _on_buy_cur_building_but_pressed():
	var error : Error = ResourcesManager.ref.consume_Pearls(Building_Cost)
	print(error)
	if error : return
	print("bought")
	ResourcesManager.ref.buy_pearl_farm()
	pass # Replace with function body.
