extends Area2D

export (PackedScene) var ProyectileScene

signal move

export var speed = 200
export var limit_px = 15
export var max_proyectiles = 5
export var delay_between_proyectiles = 0.25

var screen_size
var target = Vector2()
var hit_location = Vector2()
var is_shooting = false
var can_shoot = true
var velocity = Vector2.ZERO

var is_knockback = false



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$ProyectileDelay.wait_time = delay_between_proyectiles

func _input(event):
	if event is InputEventMouseButton:
		is_shooting = event.pressed
		if is_shooting:
			target = event.position

		
	elif event is InputEventMouseMotion:
		if is_shooting:
			target = event.position

func _physics_process(delta):
	
	if !is_knockback:
		velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		if velocity.length() > 0:
			emit_signal("move", position)
			velocity = velocity.normalized() * speed
	
		position += velocity * delta
		if can_shoot && is_shooting:
			can_shoot = false
			shoot_proyectile()
			$ProyectileDelay.start()
	else:
		velocity = hit_location
#		print(velocity)
#		print(velocity.normalized())
		emit_signal("move", position)
		velocity = velocity.normalized() * 550
		position += velocity * delta

	position.x = clamp(position.x, limit_px, screen_size.x - limit_px)
	position.y = clamp(position.y, limit_px, screen_size.y - limit_px)
	
func shoot_proyectile():
	var proyectile: Proyectile = ProyectileScene.instance()
	proyectile.position = position
	get_parent().add_child(proyectile)
	proyectile.shoot(target)
	
	


func _on_ProyectileDelay_timeout():
	can_shoot = true


func _on_Player_body_entered(body):
	if body.is_in_group("mobs"):
		hit_location = Vector2()
		if(body.position.x > position.x):
			hit_location.x -= body.position.x - position.x
		else:
			hit_location.x += position.x - body.position.x
		if(body.position.y > position.y):
			hit_location.y -= body.position.y - position.y
		else:
			hit_location.y += position.y - body.position.y
		is_knockback = true
		body.stop(0.7)
		yield(get_tree().create_timer(0.12), "timeout")
		is_knockback = false

