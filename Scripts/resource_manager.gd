class_name ResourcesManager
extends Node

#Singleton Reference
static var ref : ResourcesManager


#Singleton Setup
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal pearls_updated
#signal pearls_created
signal power_updated

signal housing_updated

#ref for game data
var data : Data = Game.ref.data

#returns amount of Pearls player has
func get_pearls() -> int:
	return data.resources.Pearls
	
func get_pearl_farms() -> int:
	return data.resources.pearl_farms

func get_power_gens() -> int:
	return data.resources.Generators

func get_power() -> int:
	return data.resources.Power

func get_max_power() -> int:
	return data.resources.Max_Power

func get_houses() -> int:
	return data.resources.Houses
	
func get_unassigned_people():
	return data.resources.Houses * 4 - get_pearl_farms()

#creates Pearls
func create_pearls(quantity:int) -> Error:
	if quantity <= 0: return FAILED
	
	data.resources.Pearls += quantity
	pearls_updated.emit()
	return OK

#returns an error value for if the player has enough pearls, and consumes them if they do
func consume_Pearls(quantity:int, can_buy: Error = OK) -> Error:
	if quantity < 0: return FAILED
	
	if quantity > data.resources.Pearls : return FAILED
	data.resources.Pearls -= quantity
	pearls_updated.emit()
	
	
	return OK
	


func consume_children(quantity):
	if quantity < 0: return FAILED
	
	if quantity > data.resources.People : return FAILED
	data.resources.People -= quantity
	housing_updated.emit()

func check_power() -> Error:
	if data.resources.Power >= data.resources.Max_Power:
		return FAILED
	return OK

func consume_Power(quantity:int) -> Error:
	if quantity < 0 : return FAILED
	
	if quantity > (data.resources.Max_Power - data.resources.Power):
		return FAILED
	data.resources.Power += 1
	power_updated.emit()
	return OK

func buy_house():
	data.resources.Houses += 1
	data.resources.People += 4
	housing_updated.emit()

func buy_power_gen():
	data.resources.Max_Power += 1
	data.resources.Generators += 1
	power_updated.emit()
func buy_pearl_farm():
	data.resources.pearl_farms += 1
