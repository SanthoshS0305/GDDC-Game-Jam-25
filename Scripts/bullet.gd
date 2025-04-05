extends CharacterBody2D

var speed: float = 500.0
var direction: Vector2
signal killedEnemy

func _ready():
	velocity = direction * speed
	self.rotation = direction.angle()
	var timer = get_tree().create_timer(2)
	timer.connect("timeout", _on_timer_timeout)
	await timer

func _on_timer_timeout():
	queue_free()

func _physics_process(delta):
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name != "Boss"):
		killedEnemy.emit()
		body.queue_free()
		queue_free()
	else:
		body.takeDamage()
