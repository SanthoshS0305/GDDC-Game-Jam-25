extends Node2D

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(Global.stages[Global.currentStage])
	pass # Replace with function body.
