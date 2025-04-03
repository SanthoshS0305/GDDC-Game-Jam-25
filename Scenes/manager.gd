extends Node2D
@export var player: CharacterBody2D
@export var enemyType: String
var enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy = load("res://Scenes/" + enemyType + ".tscn")
	spawn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn():
	var spawned = enemy.instantiate()
	spawned.setPlayer(player)
	add_child(spawned)
