extends Node2D
@export var player: CharacterBody2D
@export var enemyType: String
@export var curLevel: int
@export var nextLevel: String
@export var startDialogue: Array[Dictionary]
@export var endDialogue: Array[Dictionary]
var DialogueSys = preload("res://StartScene/DialogueSystem.tscn")

var enemy
var completed = false
##Variables that affect the spawn timing and wave mechanic
var maxWaves = 5
var curWave = 1
var enemiesSpawned = 0
var timeBetweenSpawns = 3
var lastSpawn = 0
##Distances for spawning in enemies
var maxDistanceX = 100
var maxDistanceY = 100
var cameraX = 600
var cameraY = 400
##For if dialogue is running or player is dead
var active = false
#Signals new wave
signal newWave(wave)
@onready var randomizer = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = load("res://Scenes/" + enemyType + ".tscn")
	player.victory.connect(victory)
	player.died.connect(defeat)
	Global._setLevel(curLevel)
	var dialogue_instance = DialogueSys.instantiate()
	add_child(dialogue_instance)
	dialogue_instance.start_dialogue(startDialogue)
	dialogue_instance.dialogueComplete.connect(startLevel)
	

func _physics_process(delta):
	lastSpawn += delta
	if (lastSpawn >= timeBetweenSpawns && active):
		lastSpawn = 0
		spawn()
		print("Wave: " + str(curWave))
		if ((curWave - 1) * 5 + 10 <= enemiesSpawned):
			curWave += 1
			enemiesSpawned = 0
			timeBetweenSpawns -= 0.5
			print("New Wave")
			newWave.emit(curWave)
	
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
	spawned.position = Vector2(distX, distY) + player.position
	add_child(spawned)
	enemiesSpawned += 1

func victory():
	active = false
	var dialogue_instance = DialogueSys.instantiate()
	add_child(dialogue_instance)
	dialogue_instance.start_dialogue(endDialogue)
	dialogue_instance.dialogueComplete.connect(moveToNext)

func defeat():
	call_deferred("toDefeatScreen")

func startLevel():
	active = true
	player.can_shoot = true
	player.inDialogue = false

func moveToNext():
	get_tree().change_scene_to_file(nextLevel)

func toDefeatScreen():
	get_tree().change_scene_to_file("res://Scenes/Levels/Defeat.tscn")