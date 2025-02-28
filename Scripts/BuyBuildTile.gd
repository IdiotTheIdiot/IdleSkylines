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
			if cost_floor <= 1:
				cost_floor = 1
			Building_Cost = 4 * pow(1.08, (pearl_farm_amount * (2 * cost_floor))) + pearl_farm_amount
			
			return Building_Cost
		BuildingType.POWERGEN:
			
			var power_gen_amount : int = buildings_owned
			var cost_floor : int = power_gen_amount/20
			if cost_floor <= 1:
				cost_floor = 1
			Building_Cost = 3 * pow(1.02, (power_gen_amount * (2 * cost_floor))) + power_gen_amount
			
			return Building_Cost
		BuildingType.HOUSING:
			
			var housing_amount : int = buildings_owned
			var cost_floor :int = housing_amount/20
			if cost_floor <= 1:
				cost_floor = 1
			Building_Cost = 3 * pow(1.04, (housing_amount * (2 * cost_floor))) + housing_amount
			
			return Building_Cost


func _on_buy_cur_building_but_pressed():
	
	match Building_Type:
		
		BuildingType.PEARLFARM:
			if ResourcesManager.ref.get_unassigned_people() <= 0 : return
			if ResourcesManager.ref.check_power() : return
			
			var buildcost : int = calculate_building_cost(BuildingType.PEARLFARM, ResourcesManager.ref.get_pearl_farms())
			var error : Error = ResourcesManager.ref.consume_Pearls(buildcost)
			print(Building_Cost)
			
			if error : return
			
			get_node("BuyBuildTileCont/BuyCurBuildingButCont/BuyCurBuildingBut").text = str(calculate_building_cost(BuildingType.PEARLFARM, ResourcesManager.ref.get_pearl_farms() + 1))
			
			ResourcesManager.ref.consume_children(1)
			ResourcesManager.ref.consume_Power(1)
			ResourcesManager.ref.buy_pearl_farm()
			print("bought")
		BuildingType.POWERGEN:
			
			var buildcost : int = calculate_building_cost(BuildingType.POWERGEN, ResourcesManager.ref.get_power_gens())
			var error : Error = ResourcesManager.ref.consume_Pearls(buildcost)
			print(Building_Cost)
			
			if error : return
			
			get_node("BuyBuildTileCont/BuyCurBuildingButCont/BuyCurBuildingBut").text = str(calculate_building_cost(BuildingType.POWERGEN, ResourcesManager.ref.get_power_gens() + 1))
			
			ResourcesManager.ref.buy_power_gen()
		BuildingType.HOUSING:
			
			if ResourcesManager.ref.check_power() : return
			var buildcost : int = calculate_building_cost(BuildingType.HOUSING, ResourcesManager.ref.get_houses())
			var error : Error = ResourcesManager.ref.consume_Pearls(buildcost)
			if error : return
			get_node("BuyBuildTileCont/BuyCurBuildingButCont/BuyCurBuildingBut").text = str(calculate_building_cost(BuildingType.HOUSING, ResourcesManager.ref.get_houses() + 1))
			ResourcesManager.ref.consume_Power(1)
			ResourcesManager.ref.buy_house()
