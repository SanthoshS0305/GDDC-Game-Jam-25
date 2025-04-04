extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var player = Vector2.ZERO
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if (player != null):
		direction.x = player.position.x - self.position.x
		direction.y = player.position.y - self.position.y
	velocity = direction.normalized() * SPEED
	self.rotation = direction.angle()

	move_and_slide()

func setPlayer(body: Node2D) -> void:
	player = body

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.death()
		queue_free()
