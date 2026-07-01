extends Node
class_name PlayerInput

## PlayerInput
## Captures input by bridging with the InputManager Autoload.

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	InputManager.move_input.connect(_on_move_input)

func _process(_delta: float) -> void:
	# If InputManager doesn't emit every frame (e.g. only on change),
	# we might need to poll or handle the last received value.
	# For simplicity and robustness in this modular design:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

func _on_move_input(dir: Vector2) -> void:
	direction = dir

func is_moving() -> bool:
	return direction.length() > 0
