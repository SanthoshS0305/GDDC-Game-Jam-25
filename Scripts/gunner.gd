extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player : Node2D
var inRange = false
var projSpeed = 600
var projScale = 1
var reloadTime = 0.8
var timeSinceLastShot = 0
@export var spawner: Node2D
@onready var projectile = preload("res://Scenes/projectile.tscn")

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = player.position.x - self.position.x
	direction.y = player.position.y - self.position.y
	if(!inRange):
		velocity = direction.normalized() * SPEED
	else:
		if(timeSinceLastShot >= reloadTime):
			attack()
			timeSinceLastShot = 0
	timeSinceLastShot += delta
	self.rotation = direction.angle()

	move_and_slide()

func attack():
	var bullet = projectile.instantiate()
	bullet.transform.scale.x = bullet.transform.scale.x * projScale
	bullet.transform.scale.y = bullet.transform.scale.y * projScale
	bullet.get_script().SPEED = projSpeed
	bullet.position = spawner.position
	add_child(bullet)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		inRange = true;


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		inRange = false;
