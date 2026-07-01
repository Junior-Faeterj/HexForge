extends Node
class_name PlayerInput

## PlayerInput
## Captures input by bridging with the InputManager Autoload.

signal spell_requested(index: int)

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	InputManager.move_input.connect(_on_move_input)

func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if Input.is_action_just_pressed("spell_1"): spell_requested.emit(0)
	if Input.is_action_just_pressed("spell_2"): spell_requested.emit(1)
	if Input.is_action_just_pressed("spell_3"): spell_requested.emit(2)
	if Input.is_action_just_pressed("spell_4"): spell_requested.emit(3)

func _on_move_input(dir: Vector2) -> void:
	direction = dir

func is_moving() -> bool:
	return direction.length() > 0
