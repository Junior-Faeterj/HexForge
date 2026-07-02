extends Node

## GameManager
## Responsibility: Manage global game state and resource registration.

signal game_started
signal game_over
signal victory
signal level_up(new_level: int)

var is_paused: bool = false

const DAMAGE_TEXT_SCENE = preload("res://scenes/ui/DamageText.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_register_resources()

func _register_resources() -> void:
	# In a full project, this could be a loop over resource folders
	# For now, we register known items and magic to the SaveManager database
	var magic_dir = "res://resources/magic/"
	var items_dir = "res://resources/items/"

	# Placeholder registration (simulating manual or automated discovery)
	_register_from_folder(magic_dir, SaveManager.register_magic)
	_register_from_folder(items_dir, SaveManager.register_item)

func _register_from_folder(path: String, register_func: Callable) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				var res = load(path + file_name)
				register_func.call(res)
			file_name = dir.get_next()

func start_new_game() -> void:
	game_started.emit()

func add_xp(amount: int) -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player:
		player.level.add_xp(amount)

func trigger_game_over() -> void:
	game_over.emit()
	get_tree().paused = true

func trigger_victory() -> void:
	victory.emit()
	get_tree().paused = true

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused

func spawn_damage_text(amount: float, position: Vector2, is_critical: bool = false) -> void:
	var text_instance := DAMAGE_TEXT_SCENE.instantiate() as DamageText
	get_tree().root.add_child(text_instance)
	text_instance.global_position = position
	text_instance.setup(amount, is_critical)

func manual_save() -> void:
	SaveManager.save_game()

func manual_load() -> void:
	SaveManager.load_game()
