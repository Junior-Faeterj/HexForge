extends State

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	# Phase 1 logic: Simple movement and attacks
	pass

func update(_delta: float) -> void:
	if owner.detection_area.is_target_in_range():
		state_machine.transition_to("Follow")
