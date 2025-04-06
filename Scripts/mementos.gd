extends Node2D

@export var buttons: Array[TextureButton]

func _ready() -> void:
    for i in range(Global.unlockedLevels):
        buttons[i].visible = true
    if (Global.unlockedLevels > 0):
        get_node("MementoWall").texture = load("res://Artwork/memento_wall_act_" + str(Global.unlockedLevels) + ".png")

func _on_acceptance_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Levels/Acceptance.tscn")


func _on_depression_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Levels/Depression.tscn")


func _on_bargaining_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Levels/Bargaining.tscn")


func _on_anger_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Levels/Anger.tscn")

func _on_denial_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/Levels/Denial.tscn")
