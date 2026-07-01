extends Node

## GameManager
## Responsibility: Manage global game state with Godot 4.7 static typing.

signal game_started
signal game_over
signal victory
signal level_up(new_level: int)

var is_paused: bool = false

const DAMAGE_TEXT_SCENE = preload("res://scenes/ui/DamageText.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

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
