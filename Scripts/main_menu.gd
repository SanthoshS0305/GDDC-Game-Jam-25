extends Control
@export var startScene: String

func _on_start_pressed() -> void:
    print("test")
    get_tree().change_scene_to_file(startScene)


func _on_mementos_pressed() -> void:
    if (Global.unlockedLevels > -1):
        get_tree().change_scene_to_file("res://Scenes/Mementos.tscn")
