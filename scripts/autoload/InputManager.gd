extends Node

## InputManager
## Responsibility: Decouple raw input from game actions.
## Useful for remapping and supporting multiple input devices.

signal move_input(direction: Vector2)
signal action_pressed(action_name: String)

func _process(_delta: float) -> void:
	var move_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if move_dir != Vector2.ZERO:
		move_input.emit(move_dir)

	if Input.is_action_just_pressed("attack_1"):
		action_pressed.emit("attack_1")

	if Input.is_action_just_pressed("spell_1"): action_pressed.emit("spell_1")
	if Input.is_action_just_pressed("spell_2"): action_pressed.emit("spell_2")
	if Input.is_action_just_pressed("spell_3"): action_pressed.emit("spell_3")
	if Input.is_action_just_pressed("spell_4"): action_pressed.emit("spell_4")
