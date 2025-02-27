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

#ref for game data
var data : Data = Game.ref.data

#returns amount of Pearls player has
func get_pearls() -> int:
	return data.resources.Pearls
	
func get_pearl_farms() -> int:
	return data.resources.pearl_farms

func get_power() -> int:
	return data.resources.Power

func get_max_power() -> int:
	return data.resources.Max_Power

#creates Pearls
func create_pearls(quantity:int) -> Error:
	if quantity <= 0: return FAILED
	
	data.resources.Pearls += quantity
	pearls_updated.emit()
	return OK

func consume_Pearls(quantity:int, can_buy: Error = OK) -> Error:
	if quantity < 0: return FAILED
	
	if quantity > data.resources.Pearls : return FAILED
	data.resources.Pearls -= quantity
	pearls_updated.emit()
	
	
	return OK
	

func consume_Power(quantity:int) -> Error:
	if quantity < 0 : return FAILED
	
	if quantity > (data.resources.Max_Power - data.resources.Power):
		return FAILED
	data.resources.Power += 1
	power_updated.emit()
	return OK

func buy_power_gen():
	data.resources.Max_Power += 1

func buy_pearl_farm():
	data.resources.pearl_farms += 1
