extends Node2D

@export var player: Node2D
@export var boss: Node2D
@export var curLevel: int
@export var nextLevel: String
@export var startDialogue: Array[Dictionary]
@export var firstStage: Array[Dictionary]
@export var endDialogue: Array[Dictionary]
var cur_dialogue
var DialogueSys = preload("res://StartScene/DialogueSystem.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cur_dialogue = DialogueSys.instantiate()
	add_child(cur_dialogue)
	cur_dialogue.start_dialogue(startDialogue)
	cur_dialogue.dialogueComplete.connect(startLevel)
	boss.player = player
	Global.currentStage = curLevel
	player.victory.connect(victory)
	player.died.connect(defeat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_first_phase_timeout() -> void:
	print("done")
	player.inDialogue = true
	boss.canFight = false
	if(cur_dialogue != null):
		cur_dialogue.queue_free()
	var cur_dialogue = DialogueSys.instantiate()
	add_child(cur_dialogue)
	cur_dialogue.start_dialogue(firstStage)
	cur_dialogue.dialogueComplete.connect(secondPhaseStart)

func secondPhaseStart():
	print("start")
	if(cur_dialogue != null):
		cur_dialogue.queue_free()
	get_node("FirstPhase").set_paused(true)
	player.can_shoot = true
	print(player.can_shoot)
	player.inDialogue = false
	boss.canFight = true

func victory():
	var dialogue_instance = DialogueSys.instantiate()
	add_child(dialogue_instance)
	dialogue_instance.start_dialogue(endDialogue)
	dialogue_instance.dialogueComplete.connect(moveToNext)

func defeat():
	get_tree().change_scene_to_file("res://Scenes/Levels/Defeat.tscn")
	print("Whomp whomp")

func startLevel():
	player.can_shoot = false
	player.inDialogue = false
	boss.canFight = true
	get_node("FirstPhase").start()

func moveToNext():
	get_tree().change_scene_to_file(nextLevel)
