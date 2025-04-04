extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var player: Node2D
var inRange = false
var projSpeed = 360
var projScale = 1
var reloadTime = 1
var timeSinceLastShot = 0
@export var spawner: Node2D
@onready var projectile = preload("res://Scenes/projectile.tscn")

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	velocity = Vector2.ZERO
	if (player != null):
		direction.x = player.position.x - self.position.x
		direction.y = player.position.y - self.position.y
	if (!inRange):
		velocity = direction.normalized() * SPEED
	else:
		if (timeSinceLastShot >= reloadTime):
			attack()
			timeSinceLastShot = 0
		timeSinceLastShot += delta
	self.rotation = direction.angle()

	move_and_slide()

func attack():
	var bullet = projectile.instantiate()
	bullet.setScale(projScale)
	bullet.setSpeed(projSpeed)
	bullet.position = self.global_position + spawner.position
	bullet.setTarget(player.position)
	get_tree().root.add_child(bullet)
	await get_tree().create_timer(1).timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		inRange = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		inRange = false;

func setPlayer(body: Node2D) -> void:
	player = body
