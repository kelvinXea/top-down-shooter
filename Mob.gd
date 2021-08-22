extends KinematicBody2D

class_name Mob, "Mob.gd"

export var player_position = Vector2()
export var life = 30
var it_moving = false
var speed = 0
var velocity = Vector2()
var directional_vector = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if position.distance_to(player_position) > 10:
		directional_vector = Vector2()
		directional_vector += player_position - position
		mob_movement_animation(directional_vector.normalized() * delta)
		velocity += directional_vector
		

		velocity = velocity.normalized() * speed

		if !it_moving:
			velocity = Vector2.ZERO
		velocity = move_and_slide(velocity)


func mob_movement_animation(_velocity):
	if _velocity.x > 0 && _velocity.y > 0:
		if _velocity.x > _velocity.y:
			$AnimatedSprite.play("move_right")
		else:
			$AnimatedSprite.play("move_down")
	elif _velocity.x > 0 && _velocity.y < 0:
		if _velocity.x > _velocity.y * -1:
			$AnimatedSprite.play("move_right")
		else:
			$AnimatedSprite.play("move_up")
	elif _velocity.x < 0 && _velocity.y < 0:
		if _velocity.x * -1 > _velocity.y * -1:
			$AnimatedSprite.play("move_left")
		else:
			$AnimatedSprite.play("move_up")	
	elif _velocity.x < 0 && _velocity.y > 0:
		if _velocity.x * -1 > _velocity.y:
			$AnimatedSprite.play("move_left")
		else:
			$AnimatedSprite.play("move_down")		

	

func move(_speed):
	it_moving = true
	speed = _speed
#	velocity = player_position - position

func player_moves(_position):
	player_position = _position
	
func calculate_damage(proyectile: Proyectile):
	life -= proyectile.get_hit_damage()
	var anim = proyectile.get_hit_animation()
	proyectile.proyectile_hit()
	run_damage_animation(anim, proyectile)
	print(life)
	if life <= 0:
		queue_free()

	
	
func run_damage_animation(anim, proyectile):
	var location = position - proyectile.position 
	anim.position = location * -1
	add_child(anim)
	anim.play()
	yield(anim, "animation_finished")
	anim.queue_free()

func _on_Mob_body_entered(body):
	if(body.is_in_group("player_proyectile")):
		life -= body.get_hit_damage()
		print(life)
		body.queue_free()
		if life <= 0:
			queue_free()

func stop(time):
	it_moving = false
	yield(get_tree().create_timer(time), "timeout")
	it_moving = true


func _on_Area2D_body_entered(body):
	calculate_damage(body)
