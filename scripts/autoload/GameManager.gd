extends Node

## GameManager
## Responsibility: Manage global game state, progression, and high-level logic.
## Following Singleton and Observer patterns.

signal game_started
signal game_over
signal level_up(new_level: int)

var player_level: int = 1
var player_xp: int = 0
var is_paused: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_new_game() -> void:
	player_level = 1
	player_xp = 0
	game_started.emit()

func add_xp(amount: int) -> void:
	player_xp += amount
	# Logic for leveling up would go here
	# if player_xp >= xp_threshold: level_up.emit(player_level)
	pass

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
