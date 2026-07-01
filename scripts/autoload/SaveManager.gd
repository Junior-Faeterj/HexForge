extends Node

## SaveManager
## Responsibility: Handle persistence of game data using JSON and Godot 4.7 Typed Dictionaries.

const SAVE_PATH: String = "user://hexforge_save.json"
const CONFIG_PATH: String = "user://hexforge_config.json"

signal game_saved
signal game_loaded

# Database for loading items by ID (should be populated by GameManager/Resources)
var item_database: Dictionary[String, ItemResource] = {}
# Database for loading magic by name
var magic_database: Dictionary[String, MagicResource] = {}

var autosave_timer: Timer

func _ready() -> void:
	autosave_timer = Timer.new()
	autosave_timer.wait_time = 300.0 # 5 minutes
	autosave_timer.timeout.connect(autosave_game)
	add_child(autosave_timer)
	autosave_timer.start()

func register_item(item: ItemResource) -> void:
	item_database[item.id] = item

func register_magic(magic: MagicResource) -> void:
	magic_database[magic.name] = magic

## COLLECT AND SAVE GAME DATA
func save_game() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if not player: return

	var data: Dictionary[String, Variant] = {
		"player": {
			"position": {"x": player.global_position.x, "y": player.global_position.y},
			"stats": {
				"health": player.health.current_health,
				"mana": player.mana.current_mana,
				"level": player.level.current_level,
				"xp": player.level.current_xp
			},
			"inventory": player.inventory.get_save_data(),
			"unlocked_magic": player.spells.get_unlocked_magic_names()
		},
		"timestamp": Time.get_datetime_dict_from_system()
	}

	_write_json(SAVE_PATH, data)
	game_saved.emit()
	print("Game Saved Successfully")

## LOAD AND APPLY GAME DATA
func load_game() -> void:
	var data := _read_json(SAVE_PATH)
	if data.is_empty(): return

	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if not player: return

	# Apply player data
	var p_data: Dictionary = data.get("player", {})
	var pos_data: Dictionary = p_data.get("position", {})
	player.global_position = Vector2(pos_data.get("x", 0), pos_data.get("y", 0))

	var s_data: Dictionary = p_data.get("stats", {})
	player.health.current_health = s_data.get("health", 100.0)
	player.mana.current_mana = s_data.get("mana", 50.0)
	player.level.current_level = s_data.get("level", 1)
	player.level.current_xp = s_data.get("xp", 0)

	player.inventory.load_save_data(p_data.get("inventory", []), item_database)
	player.spells.load_magic_data(p_data.get("unlocked_magic", []), magic_database)

	game_loaded.emit()
	print("Game Loaded Successfully")

func autosave_game() -> void:
	print("Autosaving...")
	save_game()

## CONFIGURATION (SETTINGS)
func save_config(config_data: Dictionary[String, Variant]) -> void:
	_write_json(CONFIG_PATH, config_data)

func load_config() -> Dictionary[String, Variant]:
	return _read_json(CONFIG_PATH)

## INTERNAL JSON UTILS
func _write_json(path: String, data: Dictionary[String, Variant]) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		var json_string := JSON.stringify(data, "\t")
		file.store_line(json_string)
		file.close()

func _read_json(path: String) -> Dictionary[String, Variant]:
	if not FileAccess.file_exists(path):
		return {}

	var file := FileAccess.open(path, FileAccess.READ)
	var json_string := file.get_as_text()
	file.close()

	var json := JSON.new()
	var parse_result := json.parse(json_string)
	if parse_result == OK:
		var result: Variant = json.get_data()
		if result is Dictionary:
			var typed_result: Dictionary[String, Variant] = {}
			for key: Variant in result.keys():
				typed_result[str(key)] = result[key]
			return typed_result

	return {}
