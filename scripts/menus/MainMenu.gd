extends Control

func _on_new_game_pressed() -> void:
	# Start fresh
	GameManager.start_new_game()
	SceneManager.change_scene("res://scenes/world/Level1.tscn")

func _on_continue_pressed() -> void:
	if FileAccess.file_exists("user://hexforge_save.json"):
		SceneManager.change_scene("res://scenes/world/Level1.tscn")
		# Load happens after level is ready
		await get_tree().process_frame
		SaveManager.load_game()

func _on_settings_pressed() -> void:
	$SettingsMenu.show()

func _on_credits_pressed() -> void:
	$CreditsMenu.show()

func _on_quit_pressed() -> void:
	get_tree().quit()
