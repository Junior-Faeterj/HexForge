extends Node

## SaveManager
## Responsibility: Handle persistence of game data (player stats, inventory, world state).
## Uses JSON or ConfigFile for serialization.

const SAVE_PATH = "user://hexforge_save.dat"

func save_game(data: Dictionary) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(data)
		file.store_line(json_string)
		file.close()
		print("Game Saved")

func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return {}

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_line()
	file.close()

	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result == OK:
		return json.get_data()

	return {}
