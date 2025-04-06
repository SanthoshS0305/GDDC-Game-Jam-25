extends Node2D

@export var buttons: Array[TextureButton]

func _ready() -> void:
    for i in range(Global.unlockedLevels):
        buttons[i].visible = true

func _on_acceptance_pressed() -> void:
    pass # Replace with function body.


func _on_depression_pressed() -> void:
    pass # Replace with function body.


func _on_bargaining_pressed() -> void:
    pass # Replace with function body.


func _on_anger_pressed() -> void:
    pass # Replace with function body.

func _on_denial_pressed() -> void:
    pass # Replace with function body.
