class_name Game 
extends Node2D

static var ref : Game

#Switch screens to buy menu
func _on_buy_buildings_button_pressed():
	Popip.hide()
	if data.resources.tutorial_complete == false:
		if data.resources.build_button_pressed_powergen == false:
			data.resources.build_button_pressed_powergen = true
			Popip.show()
			Popip.set_text("Start by purchasing a Power Generator")
			anim.play("DIPowerGenHighlight")
			Popip.position.y = 1250
		if data.resources.buy_button_pressed_powergen == true and data.resources.buy_button_pressed_housing == false:
			Popip.show()
			Popip.set_text("Purchase some Housing")
			anim.play("DIHousingHighlight")
			Popip.position.y = 725
		if data.resources.buy_button_pressed_housing == true and data.resources.buy_button_pressed_pearlfarm == false:
			Popip.show()
			Popip.set_text("Purchase a Pearl Farm")
			anim.play("DIPearlFarmHighlight")
			Popip.position.y = 1250
	%Camera2D.position.x = 1200


#Singleton Setup
func _init() -> void :
	if not ref : ref = self
	else : queue_free()

@onready var Popip : Popip = get_node("Camera2D/PopUp")
@onready var anim = %AnimationPlayer
#Ready Func
func _ready():
	update_label()
	ResourcesManager.ref.pearls_updated.connect(on_pearls_updated)
	ResourcesManager.ref.power_updated.connect(on_power_updated)
	ResourcesManager.ref.housing_updated.connect(on_housing_updated)
	ResourcesManager.ref.tutorial_powergen_purchased.connect(on_powergen_bought)
	ResourcesManager.ref.tutorial_housing_purchased.connect(on_housing_bought)
	ResourcesManager.ref.tutorial_pearlfarm_purchased.connect(on_pearlfarm_bought)
	ResourcesManager.ref.tutorial_show_pop.connect(on_show_pop)
	
	if data.resources.tutorial_complete == true:
		Popip.hide()
	
	#tutorial triggers
	if data.resources.build_button_pressed_powergen == false:
		anim.play("BuildMenuHighlightPowergen")

#DATA STORAGE
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
	(get_node("Camera2D/ColorRect/MarginContainer/GridContainer/PowerAmountLabel") as Label).text = "%s / %s" % [ResourcesManager.ref.get_power(), ResourcesManager.ref.get_max_power()]
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

func on_power_updated() -> void:
	update_label()

func on_housing_updated() -> void:
	update_label()


#tutorial signals

func on_powergen_bought() -> void:
	Popip.set_text("Power Generator Acquired! Now you have more power! Try building some Housing next.")
	%Camera2D.position.x = 0
	Popip.position.y = 725
	anim.play("BuildMenuHighlightPowergen")
	Popip.show()

func on_housing_bought() -> void:
	Popip.set_text("Housing Acquired! Now you have more people, and less available power! Try building a Pearl Farm next.")
	%Camera2D.position.x = 0
	Popip.position.y = 725
	anim.play("BuildMenuHighlightPowergen")
	Popip.show()

func on_pearlfarm_bought() -> void:
	Popip.set_text("Pearl Farm Acquired! Now you have fewer people, and less available power, but each farm generates 1 pearl per second!")
	%Camera2D.position.x = 0
	Popip.position.y = 725
	anim.play("BuildMenuHighlightPowergen")
	Popip.show()
	Popip.reveal_button()
	get_node("RedArrow1").hide()

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	
func on_show_pop():
	get_node("RedArrow1").hide()
