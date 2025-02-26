class_name Game 
extends Node2D

static var ref : Game

#Switch screens to buy menu
func _on_buy_buildings_button_pressed():
	%Camera2D.position.x = 1200
#	%Camera2D.position.y = 

#Singleton Setup
func _init() -> void :
	if not ref : ref = self
	else : queue_free()

#Ready Func
func _ready():
	update_label()
	ResourcesManager.ref.pearls_updated.connect(on_pearls_updated)

const PATH : String= "user://save.tres"
#main Data object
var data : Data = load_data()

#Save Game function
func save_data() -> void:
	ResourceSaver.save(data,PATH)

#save upon exiting
func _exit_tree() -> void:
	save_data()

#load data function
func load_data() -> Data:
	if ResourceLoader.exists(PATH) : return load(PATH)
	return Data.new()


#Update Labels Functions
func update_label() -> void:
	(get_node("Camera2D/ColorRect/MarginContainer/GridContainer/PearlsAmountLabel") as Label).text = str(ResourcesManager.ref.get_pearls())
	(get_node("Camera2D/ColorRect/MarginContainer/GridContainer/PowerAmountLabel") as Label).text = str(data.resources.Power) 
	(get_node("Camera2D/ColorRect/MarginContainer/GridContainer/PeopleAmountLabel") as Label).text = str(data.resources.People)

 
#generate Pearls and Update 
func create_pearls() -> void:
	ResourcesManager.ref.create_pearls(5)
	update_label()


#debug Buttons setup

func _on_pearls_butt_pressed():
	create_pearls()
	print(ResourcesManager.ref.get_pearls())

func _on_power_butt_pressed():
	data.resources.Power += 1
	update_label()

func _on_people_butt_pressed():
	data.resources.People += 1
	update_label()


#updates the label when main scene is opened
func _on_tree_entered():
	update_label()


func on_pearls_updated() -> void:
	update_label()
