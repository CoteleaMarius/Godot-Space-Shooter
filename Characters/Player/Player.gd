extends Area2D

class_name Player

signal spawn_laser(location)

onready var weapon = $Weapon
onready var healthLabel = $CanvasLayer/Health
onready var laserBeam = $laserBeam

var speed = 300

var hp = 3

var input_vector = Vector2.ZERO

func _physics_process(delta):
	healthLabel.text = "Health: " + str(hp)
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	global_position += input_vector * speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		shoot_laser()
	
	var screen_size = get_viewport().get_visible_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_just_pressed("reset_position"):
		var random_position = Vector2(
			rand_range(0, screen_size.x),
			rand_range(0, screen_size.y)
		)
		global_position = random_position
		
func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()


func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(1)
	if area.is_in_group("heart"):
		area.queue_free()
		hp += 1


func shoot_laser():
	emit_signal("spawn_laser", weapon.global_position)
	laserBeam.play()
