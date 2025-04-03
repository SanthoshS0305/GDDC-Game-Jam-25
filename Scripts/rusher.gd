extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0
var playerPos = Vector2.ZERO
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = playerPos.x - self.position.x
	direction.y = playerPos.y - self.position.y
	velocity = direction.normalized() * SPEED
	self.rotation = direction.angle()

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		print("fail")
		queue_free()
