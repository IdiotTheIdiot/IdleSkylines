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
#signal 

#ref for game data
var data : Data = Game.ref.data

#returns amount of Pearls player has
func get_pearls() -> int:
	return data.resources.Pearls
	

#creates Pearls
func create_pearls(quantity:int) -> Error:
	if quantity <= 0: return FAILED
	
	data.resources.Pearls += quantity
	pearls_updated.emit()
	return OK
	
func consume_Pearls(quantity:int) -> Error:
	if quantity < 0: return FAILED
	
	if quantity < data.resources.Pearls : return FAILED
	pearls_updated.emit()
	
	data.resources.Pearls -= quantity
	return OK
