extends CharacterBody2D


const SPEED = 600
const JUMP_VELOCITY = -400.0
var playerPos = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = playerPos.x - self.position.x
	direction.y = playerPos.y - self.position.y
	print(self.position)
	velocity = direction.normalized() * SPEED
	move_and_slide()


func _on_timer_timeout() -> void:
	print("death")
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		print("Death")
		queue_free()
