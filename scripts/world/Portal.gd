extends Area2D
class_name Portal

## Portal
## Responsibility: Triggers scene transitions between levels.

@export_file("*.tscn") var target_scene_path: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player and target_scene_path != "":
		SceneManager.change_scene(target_scene_path)
