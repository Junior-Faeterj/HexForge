extends Node
class_name State

## State
## Base class for Finite State Machine states.

var state_machine = null

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
