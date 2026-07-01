extends Node
class_name PlayerFSM

## PlayerFSM
## Specialized StateMachine for the Player.

func transition_to(target_state_name: String, msg: Dictionary[String, Variant] = {}) -> void:
	super.transition_to(target_state_name, msg)
