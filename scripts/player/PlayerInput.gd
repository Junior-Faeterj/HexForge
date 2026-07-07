extends Node
class_name PlayerInput

## PlayerInput
## Captures input by bridging with the InputManager Autoload.

signal spell_requested(index: int, direction: Vector2)
signal interact_requested

var direction: Vector2 = Vector2.ZERO
var last_move_direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	InputManager.move_input.connect(_on_move_input)
	InputManager.action_pressed.connect(_on_action_pressed)

func _on_action_pressed(action_name: String) -> void:
	match action_name:
		"spell_1": spell_requested.emit(0, last_move_direction)
		"spell_2": spell_requested.emit(1, last_move_direction)
		"spell_3": spell_requested.emit(2, last_move_direction)
		"spell_4": spell_requested.emit(3, last_move_direction)
		"interact": interact_requested.emit()

func _on_move_input(dir: Vector2) -> void:
	direction = dir
	if dir != Vector2.ZERO:
		last_move_direction = dir.normalized()

func is_moving() -> bool:
	return direction.length() > 0
