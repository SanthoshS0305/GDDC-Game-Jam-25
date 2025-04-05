extends Node

@onready var speaker_label = $SpeakerLabel
@onready var dialogue_label = $DialogueLabel
signal dialogueComplete

var dialogue: Array = []
var current_index: int = 0

func _ready():
	show_dialogue()

func start_dialogue(input_dialogue: Array):
	dialogue = input_dialogue
	current_index = 0
	show_dialogue()

func show_dialogue():
	if current_index < dialogue.size():
		$ColorRect.show()
		$DialogueLabel.show()
		$SpeakerLabel.show()
		var line = dialogue[current_index]
		speaker_label.text = line["speaker"]
		dialogue_label.text = line["text"]
	else:
		speaker_label.text = ""
		dialogue_label.text = "End of conversation."
		$ColorRect.hide()
		$DialogueLabel.hide()
		$SpeakerLabel.hide()
		dialogueComplete.emit()

func _input(event):
	if event.is_pressed() and not event.is_echo():
		current_index += 1
		show_dialogue()
