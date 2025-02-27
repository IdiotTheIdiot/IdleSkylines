class_name BuyBuildTile
extends Control


@export var Building_Type : int = 1
@export var Building_Cost : int = 15

func _ready():
	if Building_Type == 1:
		get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Pearl Farms"
	if Building_Type == 2:
		get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Power Generator"
	if Building_Type == 3:
		get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Housing"

func calculate_building_cost(building_type : int, buildings_owned : int):
	if building_type == 1:
		var pearl_farm_amount : int = buildings_owned
		var cost_floor : int = pearl_farm_amount/20
		Building_Cost = 4 * pow(1.08, (pearl_farm_amount * pow(2, cost_floor)))
		return Building_Cost
	if building_type == 2:
	
		return Building_Cost


func _on_buy_cur_building_but_pressed():
	if Building_Type == 1:
		
		var error : Error = ResourcesManager.ref.consume_Pearls(calculate_building_cost(1, ResourcesManager.ref.get_pearl_farms()))
		print(Building_Cost)
		get_node("BuyBuildTileCont/BuyCurBuildingButCont/BuyCurBuildingBut").text = str(calculate_building_cost(1, ResourcesManager.ref.get_pearl_farms()))
		if error : return
		print("bought")
		ResourcesManager.ref.buy_pearl_farm()
	pass # Replace with function body.
