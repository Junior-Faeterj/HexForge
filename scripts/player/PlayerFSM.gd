extends Node
class_name PlayerFSM

## PlayerFSM
## Specialized StateMachine for the Player.

func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	super.transition_to(target_state_name, msg)
