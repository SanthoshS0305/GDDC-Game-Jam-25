extends CharacterBody2D

@export var level: Node2D
@export var waveCounter: RichTextLabel
@export var firingPoint: Node2D
var speed: float = 320.0
var bullet_path = preload("res://Scenes/bullet.tscn")
var killedEnemies = 0
#For controlling player's avaliabe actions during the level
var can_shoot = true
var inDialogue = true
#Number of enemies to kil to pass the level
var victoryCondition = 10
#Signals to indicate game state
signal victory
signal died

func _ready():
	if (level != null):
		level.newWave.connect(changeWaveCounter)

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if !inDialogue:
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

	if Input.is_action_pressed("mouse_left") && can_shoot: # Ensure "mouse_left" is mapped in InputMap
		if can_shoot == true:
			shoot()
			can_shoot = false
			var timer = get_tree().create_timer(.5)
			timer.connect("timeout", _on_timer_timeout)

func _on_timer_timeout():
	can_shoot = true

func shoot():
	var bullet = bullet_path.instantiate()
	bullet.position = firingPoint.global_position
	bullet.rotation = get_angle_to(get_global_mouse_position())
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	bullet.killedEnemy.connect(killEnemy)
	get_parent().add_child(bullet)

func killEnemy():
	print("Killer killer")
	killedEnemies += 1
	if (killedEnemies > victoryCondition):
		victory.emit()

func death():
	print("bleh")
	died.emit()

func changeWaveCounter(wave: int):
	print("Updating")
	waveCounter.text = "Wave: " + str(wave)
