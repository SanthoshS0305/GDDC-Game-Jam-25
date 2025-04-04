extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var player: Node2D
var inGunRange = false
var inMelee = false
var projSpeed = 450
var projScale = 1
var reloadTime = 1
var timeSinceLastShot = 0
var canFight = true
var invulnerable = 2
var timeSinceLastHit = 2
var hp = 5
@export var spawner: Node2D
@export var animation: AnimationPlayer
@onready var projectile = preload("res://Scenes/projectile.tscn")
@onready var randomizer = RandomNumberGenerator.new()
signal victory

func _ready() -> void:
	get_node("Weapon").visible = false

func _physics_process(delta: float) -> void:
	if canFight:
		var direction = Vector2.ZERO
		velocity = Vector2.ZERO
		if (player != null):
			direction.x = player.position.x - self.position.x
			direction.y = player.position.y - self.position.y
		if (inMelee):
			animation.play("attack")
		elif (inGunRange):
			if (timeSinceLastShot >= reloadTime):
				attack()
				timeSinceLastShot = 0
			timeSinceLastShot += delta
		else:
			velocity = direction.normalized() * SPEED
		self.rotation = direction.angle()
	timeSinceLastHit += delta
	move_and_slide()

func attack():
	var rand = randomizer.randi_range(0, 1)
	rangedAttack()
	if (rand == 0):
		pass

func rangedAttack():
	for i in range(3):
		var bullet = projectile.instantiate()
		bullet.setScale(projScale)
		bullet.setSpeed(projSpeed)
		bullet.position = self.global_position + spawner.position
		bullet.setTarget(player.position)
		get_tree().root.add_child(bullet)
		await get_tree().create_timer(0.1).timeout
	

func setPlayer(body: Node2D) -> void:
	player = body

func takeDamage():
	if timeSinceLastHit > invulnerable:
		hp -= 1
		if (hp <= 0):
			victory.emit()
		timeSinceLastHit = 0


func _on_ranged_range_body_exited(body: Node2D) -> void:
	inGunRange = false

func _on_ranged_range_body_entered(body: Node2D) -> void:
	inGunRange = true

func _on_melee_range_body_exited(body: Node2D) -> void:
	inMelee = false
func _on_melee_range_body_entered(body: Node2D) -> void:
	print("test")
	inMelee = true
