extends StaticBody2D
var DialogueSys = preload("res://StartScene/DialogueSystem.tscn")
@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
signal ending
var canInteract = false

func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	interactable.is_interactable = false
	var my_dialogue = [
		{"speaker": "Mirabelle", "text": "There is no noise is there? There's just me and this gun. Colin's never coming back. I'm alone..."},
		{"speaker": "Narrator", "text": "Memento Found: Gun."},
		{"speaker": "Mirabelle", "text": "There's no one out there. I need to put this away."},
		{"speaker": "Narrator", "text": "Gun appears on stand above the mantle."}]
	var dialogue_instance = DialogueSys.instantiate()
	add_child(dialogue_instance)
	dialogue_instance.dialogueComplete.connect(end)
	dialogue_instance.start_dialogue(my_dialogue)

func end():
	ending.emit()
