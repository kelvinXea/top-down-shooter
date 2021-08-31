extends KinematicBody2D

class_name Proyectile, "Proyectile.gd"

export var speed = 500
export var base_damge = 5
export var min_damage = 8
export var max_damage = 12
export (PackedScene) var hit_animation
var is_shooted = false
var velocity = Vector2.ZERO
var target

func _process(delta):
	if is_shooted:
		velocity = velocity.normalized() * speed
	var _collide = move_and_collide(velocity * delta)

func get_proyectile_speed():
	return speed	

# warning-ignore:shadowed_variable
func shoot(target: Vector2):
	self.target = target
	velocity = target - position
	is_shooted = true

func get_hit_damage():
	var rand_damage = (randf() * (max_damage - min_damage)) + min_damage
	return base_damge + rand_damage / 2
	
func get_hit_sound() -> Node:
	return $Hit_Sound

func proyectile_hit() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.hide()
	$Hit_Sound.play()
	yield($Hit_Sound, "finished")
	queue_free()
	
	
func get_hit_animation() -> AnimatedSprite:
	return hit_animation.instance()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
