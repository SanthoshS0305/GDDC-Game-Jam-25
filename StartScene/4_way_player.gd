extends CharacterBody2D

var inDialogue = true
var speed: float = 200.0
@onready var animatedSprite: AnimatedSprite2D = $Animated

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if !inDialogue:
		if Input.is_action_pressed("right"):
			direction.x += 1
		elif Input.is_action_pressed("left"):
			direction.x -= 1
		elif Input.is_action_pressed("down"):
			direction.y += 1
		elif Input.is_action_pressed("up"):
			direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
		if (direction.y < 0):
			animatedSprite.play("walk_up")
		else:
			animatedSprite.play("walk_down")
	else:
		velocity = Vector2.ZERO
		animatedSprite.play("idle")

	move_and_slide()
