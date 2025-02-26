class_name PearlGenerator
extends Node

#single ref
static var ref : PearlGenerator

#Singleton Setup
func _init() -> void :
	if not ref : ref = self
	else : queue_free()


#duration of production cycle in ticks
var _cycle_duration : float = 3.0
#progress for next cycle
var _cycle_progression : float = 0.0
#resources produced each cycle
var _production : int = 1
#pause status 
var _paused : bool = false

#Ready connection to clock
func _ready() -> void:
	Clock.ref.ticked.connect(_on_clock_ticked)
	
#cycles once every %_cycle_duration game ticks
func _progress_cycle() -> void:
	if _paused : return
	_cycle_progression += 1.0

	if _cycle_progression >= _cycle_duration:
		_generate()
		

#generate resources and reset cycle progress
func _generate() -> void:
	_production = (ResourcesManager.ref.get_pearl_farms() * 3) + 1
	_cycle_progression -= _cycle_duration
	ResourcesManager.ref.create_pearls(_production)


func _on_clock_ticked() -> void:
	_progress_cycle()
	

