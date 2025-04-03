extends CharacterBody2D

var speed: float = 500.0
var direction: Vector2

func _ready():
	velocity = direction * speed
	rotation = get_angle_to(direction.normalized())
	var timer = get_tree().create_timer(2)
	timer.connect("timeout", _on_timer_timeout)
	await timer

func _on_timer_timeout():
	queue_free()

func _physics_process(delta):
	move_and_slide()
