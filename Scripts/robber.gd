extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var playerPos = Vector2.ZERO
var inRange = false
@export var animation: AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if(!inRange):
		direction.x = playerPos.x - self.position.x
		direction.y = playerPos.y - self.position.y
	else:
		animation.play("Attack")
	velocity = direction.normalized() * SPEED
	self.rotation = direction.angle()

	move_and_slide()

func attack():
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inRange = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inRange = true;
