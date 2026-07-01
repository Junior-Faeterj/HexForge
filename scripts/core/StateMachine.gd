extends Node
class_name StateMachine

## StateMachine
## Manages state transitions and delegates updates to the active state.

signal transitioned(state_name: String)

@export var initial_state: NodePath

@onready var state: State = get_node(initial_state)

func _ready() -> void:
	await owner.ready
	for child in get_children():
		if child is State:
			child.state_machine = self
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state_name: String, msg: Dictionary[String, Variant] = {}) -> void:
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name) as State
	state.enter(msg)
	transitioned.emit(state.name)
