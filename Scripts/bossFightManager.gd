extends Node2D

@export var player: Node2D
@export var boss: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_shoot = false
	boss.player = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_first_phase_timeout() -> void:
	print("done")
	player.inDialogue = true
	boss.canFight = false

func secondPhaseStart():
	player.can_shoot = true
	player.inDialogue = false
	boss.canFight = true
