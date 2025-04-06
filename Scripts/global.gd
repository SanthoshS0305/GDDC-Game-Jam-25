extends Node

var stages = ["res://Scenes/Levels/Denial.tscn", "res://Scenes/Levels/Anger.tscn", "res://Scenes/Levels/Bargaining.tscn", "res://Scenes/Levels/Depression.tscn", "res://Scenes/Levels/Acceptance.tscn"]
var currentStage: int
var unlockedLevels = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setLevel(level: int):
	currentStage = level
	unlockedLevels = maxi(unlockedLevels, level)