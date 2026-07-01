extends Node

## SceneManager
## Responsibility: Manage scene transitions, loading screens, and level switching.

signal scene_transition_started
signal scene_transition_finished

var loading_screen_scene = preload("res://scenes/menus/LoadingScreen.tscn")

func change_scene(scene_path: String) -> void:
	scene_transition_started.emit()

	# Show loading screen
	var loading_screen = loading_screen_scene.instantiate()
	get_tree().root.add_child(loading_screen)

	# Small delay to simulate transition
	await get_tree().create_timer(0.5).timeout

	get_tree().change_scene_to_file(scene_path)

	loading_screen.queue_free()
	scene_transition_finished.emit()

func reload_current_scene() -> void:
	get_tree().reload_current_scene()
