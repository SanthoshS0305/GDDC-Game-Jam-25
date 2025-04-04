extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var player: Node2D
var inRange = false
var restTime = 0.2
var timeSinceLastAttack = 0
@export var animation: AnimationPlayer

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	velocity = Vector2.ZERO
	if (player != null):
		direction.x = player.position.x - self.position.x
		direction.y = player.position.y - self.position.y
	if (!inRange && !animation.is_playing()):
		velocity = direction.normalized() * SPEED
	elif (timeSinceLastAttack >= restTime):
		animation.play("Attack")
	self.rotation = direction.angle()
	timeSinceLastAttack += delta
	move_and_slide()
	
func setPlayer(body: Node2D) -> void:
	player = body

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		inRange = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("exit")
	if (body.name == "Player"):
		inRange = false;
