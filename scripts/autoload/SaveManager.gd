extends Node

## SaveManager
## Responsibility: Handle persistence of game data using Godot 4.7 Typed Dictionaries.

const SAVE_PATH: String = "user://hexforge_save.dat"

func save_game(data: Dictionary[String, Variant]) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string := JSON.stringify(data)
		file.store_line(json_string)
		file.close()
		print("Game Saved")

func load_game() -> Dictionary[String, Variant]:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string := file.get_line()
	file.close()

	var json := JSON.new()
	var parse_result := json.parse(json_string)
	if parse_result == OK:
		var result: Variant = json.get_data()
		if result is Dictionary:
			# Cast to typed dictionary
			var typed_result: Dictionary[String, Variant] = {}
			for key: Variant in result.keys():
				typed_result[str(key)] = result[key]
			return typed_result

	return {}
