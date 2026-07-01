extends State

func physics_update(_delta: float) -> void:
	var target = owner.detection_area.current_target
	if not target:
		state_machine.transition_to("Idle")
		return

	var dist := owner.global_position.distance_to(target.global_position)
	if dist < 40.0: # Attack range
		state_machine.transition_to("Attack")
		return

	var dir := (target.global_position - owner.global_position).normalized()
	owner.velocity = dir * owner.stats.movement_speed
	owner.move_and_slide()

	if dist > owner.stats.detection_range * 1.2:
		state_machine.transition_to("Idle")
