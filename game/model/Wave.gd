extends Node
class_name Wave, "Wave.gd"

export var monster_spawns : Array = []
export var spawn_speed = 2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init(_monster_spawns: Array = []):
	monster_spawns = _monster_spawns


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
