extends Control

func _on_restart_pressed() -> void:
	get_tree().paused = false
	SceneManager.reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	SceneManager.change_scene("res://scenes/menus/MainMenu.tscn")
