extends StaticBody2D
var DialogueSys = preload("res://StartScene/DialogueSystem.tscn")
@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	interactable.is_interactable = false
	var my_dialogue = [
		{"speaker": "Gun", "text": "I am a fucking gun!"},
		{"speaker": "MC", "text": "Okay man."},
		{"speaker": "Gun", "text": "Go fucking die dickhead."},
		{"speaker": "MC", "text": "Ok man."}]
	var dialogue_instance = DialogueSys.instantiate()
	add_child(dialogue_instance)
	dialogue_instance.start_dialogue(my_dialogue)

	
	
