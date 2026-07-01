extends Node

## GameManager
## Responsibility: Manage global game state with Godot 4.7 static typing.

signal game_started
signal game_over
signal victory
signal level_up(new_level: int)

var player_level: int = 1
var player_xp: int = 0
var is_paused: bool = false

const DAMAGE_TEXT_SCENE = preload("res://scenes/ui/DamageText.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_new_game() -> void:
	player_level = 1
	player_xp = 0
	game_started.emit()

func add_xp(amount: int) -> void:
	player_xp += amount
	# Logic for leveling up is handled in PlayerLevel component,
	# but we can track global state here too.
	pass

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
