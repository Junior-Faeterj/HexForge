extends State

func update(_delta: float) -> void:
	if owner.input.is_moving():
		state_machine.transition_to("Move")

func physics_update(_delta: float) -> void:
	owner.movement.move(Vector2.ZERO)
	owner.animation.update_animation(Vector2.ZERO, false)
