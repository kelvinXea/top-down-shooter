extends Node
class_name Stage, "Stage.gd"

var time_per_wave: int 
export var waves : Array = []


func _init(_waves : Array = [], _time_per_wave = 0):
	waves = _waves
	time_per_wave = _time_per_wave
