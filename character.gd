extends CharacterBody2D

var speed: float = 200.0
var bullet_path = preload("res://bullet.tscn")
var can_shoot = true

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("mouse_left"):  # Ensure "mouse_left" is mapped in InputMap
		if can_shoot == true:
			shoot()
			can_shoot = false
			var timer = get_tree().create_timer(.5)
			timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	can_shoot = true

func shoot():
	var bullet = bullet_path.instantiate()
	bullet.position = $Node2D2.global_position
	bullet.rotation = get_angle_to(get_global_mouse_position())
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	get_parent().add_child(bullet)
