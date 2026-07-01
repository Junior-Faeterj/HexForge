extends Node
class_name PlayerInput

## PlayerInput
## Captures input by bridging with the InputManager Autoload.

signal spell_requested(index: int, direction: Vector2)

var direction: Vector2 = Vector2.ZERO
var last_move_direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	InputManager.move_input.connect(_on_move_input)

func _process(_delta: float) -> void:
	# Rely on Autoload data via _on_move_input
	if Input.is_action_just_pressed("spell_1"): spell_requested.emit(0, last_move_direction)
	if Input.is_action_just_pressed("spell_2"): spell_requested.emit(1, last_move_direction)
	if Input.is_action_just_pressed("spell_3"): spell_requested.emit(2, last_move_direction)
	if Input.is_action_just_pressed("spell_4"): spell_requested.emit(3, last_move_direction)

func _on_move_input(dir: Vector2) -> void:
	direction = dir
	if dir != Vector2.ZERO:
		last_move_direction = dir.normalized()

func is_moving() -> bool:
	return direction.length() > 0
