extends Node
class_name PlayerLevel

## PlayerLevel
## Manages XP accumulation and leveling up.

signal level_up(new_level: int)
signal xp_changed(current_xp: int, next_level_xp: int)

@export var current_level: int = 1
@export var current_xp: int = 0
@export var xp_requirement_base: int = 100
@export var xp_multiplier: float = 1.5

func get_next_level_requirement() -> int:
	return int(xp_requirement_base * pow(xp_multiplier, current_level - 1))

func add_xp(amount: int) -> void:
	current_xp += amount
	var required = get_next_level_requirement()

	while current_xp >= required:
		current_xp -= required
		current_level += 1
		level_up.emit(current_level)
		required = get_next_level_requirement()

	xp_changed.emit(current_xp, required)
