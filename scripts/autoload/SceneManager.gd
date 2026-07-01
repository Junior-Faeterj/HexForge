extends Node

## SceneManager
## Responsibility: Manage scene transitions, loading screens, and level switching.

signal scene_transition_started
signal scene_transition_finished

func change_scene(scene_path: String) -> void:
	scene_transition_started.emit()

	# Optional: Add delay or loading animation here
	get_tree().change_scene_to_file(scene_path)

	scene_transition_finished.emit()

func reload_current_scene() -> void:
	get_tree().reload_current_scene()
