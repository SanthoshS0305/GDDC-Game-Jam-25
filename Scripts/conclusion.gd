extends Node2D
@export var gun: Node2D
@export var player: Node2D
@export var dialogue: Array[Dictionary]
var cur_dialogue
var DialogueSys = preload("res://StartScene/DialogueSystem.tscn")

func _ready() -> void:
	Global._setLevel(5)
	gun.ending.connect(backToStart)
	cur_dialogue = DialogueSys.instantiate()
	add_child(cur_dialogue)
	cur_dialogue.start_dialogue(dialogue)
	cur_dialogue.dialogueComplete.connect(allowMovement)

func allowMovement():
	player.inDialogue = false

func backToStart():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
