class_name BuyBuildTile
extends Control

#Building types
#1 = Pearl Farms
#2 = Power Gens
#3 = Housing
enum BuildingType {PEARLFARM, POWERGEN, HOUSING}
@export var Building_Type : BuildingType
@export var Building_Cost : int = 15


func _ready():
	
	match Building_Type:
		BuildingType.PEARLFARM:
			
			get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Pearl Farms"
		BuildingType.POWERGEN:
			
			get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Power Generator"
		BuildingType.HOUSING:
			
			get_node("BuyBuildTileCont/BuildingLabelCont/BuildingLabel").text = "Housing"


func calculate_building_cost(building_type : BuildingType, buildings_owned : int):
	match Building_Type:
		BuildingType.PEARLFARM:
			var pearl_farm_amount : int = buildings_owned
			var cost_floor : int = pearl_farm_amount/20
			Building_Cost = 4 * pow(1.08, (pearl_farm_amount * pow(2, cost_floor)))
			return Building_Cost
		BuildingType.POWERGEN:
		
			return Building_Cost


func _on_buy_cur_building_but_pressed():
	print("pressed")
	match Building_Type:
		
		BuildingType.PEARLFARM:
			
			var buildcost : int = calculate_building_cost(BuildingType.PEARLFARM, ResourcesManager.ref.get_pearl_farms())
			var error : Error = ResourcesManager.ref.consume_Pearls(buildcost)
			print(Building_Cost)
			get_node("BuyBuildTileCont/BuyCurBuildingButCont/BuyCurBuildingBut").text = str(calculate_building_cost(BuildingType.PEARLFARM, ResourcesManager.ref.get_pearl_farms()))
			
			var Perror : Error = ResourcesManager.ref.consume_Power(1)
			if error or Perror :
				print(error, Perror) 
				ResourcesManager.ref.create_pearls(buildcost)
				return
			
			ResourcesManager.ref.buy_pearl_farm()
			print("bought")
		BuildingType.POWERGEN:
			return 
			
