extends Node

## GameManager
## Responsibility: Manage global game state with Godot 4.7 static typing.

signal game_started
signal game_over
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
	# Logic for leveling up would go here
	pass

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused

func spawn_damage_text(amount: float, position: Vector2, is_critical: bool = false) -> void:
	var text_instance := DAMAGE_TEXT_SCENE.instantiate() as DamageText
	get_tree().root.add_child(text_instance)
	text_instance.global_position = position
	text_instance.setup(amount, is_critical)
