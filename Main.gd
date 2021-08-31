extends Node2D

var wave_number = 10
var player_positon
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Stage/Player.set_life_bar($Stage/PlayerHealth)
	var spawn = Spawn.new()
	spawn.monsters_spaws.append([
		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position)
		])
	spawn.monsters_spaws.append([
		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
		])
	spawn.monsters_spaws.append([
		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
		])
	spawn.monsters_spaws.append([
		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
		])
#	spawn.monsters_spaws.append([
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint2.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
#		])
#	spawn.monsters_spaws.append([
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint2.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
#		])
#	spawn.monsters_spaws.append([
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint2.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
#		])
#	spawn.monsters_spaws.append([
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint1.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint2.position),
#		MonsterSpawn.new($Stage/StageManager/SpawnPoint3.position)
#		])
	
	var wave = Wave.new([spawn,spawn])
	var stage = Stage.new([wave])
	
	load_stage(stage)

	
func load_stage(stage: Stage):
	$Stage/StageManager.start(stage, $Stage/Player.position)


func _on_Player_move(_position):
	get_tree().call_group("mobs","player_moves",_position)
