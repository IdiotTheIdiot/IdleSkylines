class_name DataResources
extends Resource


#resources player owns

@export var Pearls : int = 0
@export var Power : int = 0
@export var Max_Power : int = 10
@export var People : int = 0


#buildings player owns

@export var Generators : int = 0
@export var pearl_farms : int = 0
@export var Houses : int = 0

#Quest Flags

@export var tutorial_complete : bool = false
@export var build_button_pressed_powergen : bool = false
@export var buy_button_pressed_powergen : bool = false
@export var buy_button_pressed_housing : bool = false
@export var buy_button_pressed_pearlfarm : bool = false
