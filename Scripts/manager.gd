extends Node2D
@export var player: CharacterBody2D
@export var enemyType: String
var enemy
var completed = false
var maxWaves = 5
var curWave = 0
var enemiesSpawned = 0
var timeBetweenSpawns = 3
var lastSpawn = 0
var maxDistanceX = 100
var maxDistanceY = 100
var cameraX = 600
var cameraY = 400
var active = true
@onready var randomizer = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = load("res://Scenes/" + enemyType + ".tscn")
	spawn()
	pass # Replace with function body.


func _physics_process(delta):
	lastSpawn += delta
	if (lastSpawn >= timeBetweenSpawns):
		lastSpawn -= timeBetweenSpawns
		spawn()
	
func spawn():
	var leftOrRight = randomizer.randi_range(0, 1)
	var upOrDown = randomizer.randi_range(0, 1)
	if (leftOrRight == 0):
		leftOrRight = -1
	if (upOrDown == 0):
		upOrDown = -1
	var distX = (randomizer.randf_range(0, maxDistanceX) + cameraX) * leftOrRight
	var distY = (randomizer.randf_range(0, maxDistanceY) + cameraY) * upOrDown
	var spawned = enemy.instantiate()
	spawned.setPlayer(player)
	spawned.position = Vector2(distX, distY)
	add_child(spawned)
