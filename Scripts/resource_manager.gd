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

signal tutorial_powergen_purchased

signal tutorial_housing_purchased

signal tutorial_pearlfarm_purchased

signal tutorial_show_pop
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
	return data.resources.Houses * 2 - get_pearl_farms()

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
	data.resources.People += 2
	housing_updated.emit()

func buy_power_gen():
	data.resources.Max_Power += 3
	data.resources.Generators += 1
	power_updated.emit()
	
func buy_pearl_farm():
	data.resources.pearl_farms += 1
	
	
#tutorial signals
func powergen_purchased():
	tutorial_powergen_purchased.emit()

func housing_purchased():
	tutorial_housing_purchased.emit()

func pearlfarm_purchased():
	tutorial_pearlfarm_purchased.emit()

func get_data(datars : String):
	if datars == "buy_button_pressed_powergen":
		return data.resources.buy_button_pressed_powergen
	if datars == "buy_button_pressed_housing":
		return data.resources.buy_button_pressed_housing
	if datars == "buy_button_pressed_pearlfarm":
		return data.resources.buy_button_pressed_pearlfarm
func set_data(datars : String, bool):
	if datars == "buy_button_pressed_powergen":
		data.resources.buy_button_pressed_powergen = bool
	if datars == "buy_button_pressed_housing":
		data.resources.buy_button_pressed_housing = bool
	if datars == "buy_button_pressed_pearlfarm":
		data.resources.buy_button_pressed_pearlfarm = bool
		
func finish_tutorial():
	data.resources.tutorial_complete = true
	show_pop_button()
	
func show_pop_button():
	tutorial_show_pop.emit()
