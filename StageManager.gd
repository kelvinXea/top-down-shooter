extends Node2D

export (PackedScene) var Mob

var player_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start(stage: Stage, _player_position):
	player_position = _player_position
	for _wave in stage.waves:
		var wave: Wave = _wave
		for _monster_spawn in wave.monster_spawns:
			var monster_spawn : MonsterSpawn = _monster_spawn
			var mob = Mob.instance()
			mob.player_position = player_position
			mob.position = monster_spawn.position
			get_parent().add_child(mob)
			mob.move(150)
			yield(get_tree().create_timer(wave.spawn_speed), "timeout")
		
	


func _on_Player_move(_position):
	player_position = _position
	get_tree().call_group("mobs","player_moves", player_position)
