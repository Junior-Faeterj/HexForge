extends State

func update(_delta: float) -> void:
	if not owner.input.is_moving():
		state_machine.transition_to("Idle")

func physics_update(_delta: float) -> void:
	var dir = owner.input.direction
	owner.movement.move(dir)
	owner.animation.update_animation(dir, true)
