extends CharacterBody2D


var speed = 600
var playerPos = Vector2.ZERO
var direction = Vector2.ZERO

func _ready() -> void:
	direction.x = playerPos.x - self.position.x
	direction.y = playerPos.y - self.position.y

func setTarget(position: Vector2):
	playerPos = position

func setScale(scale: float):
	self.scale *= scale

func setSpeed(speed: int):
	self.speed = speed

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.death()
		queue_free()
