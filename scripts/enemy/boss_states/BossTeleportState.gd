extends State

func enter(_msg: Dictionary = {}) -> void:
	# Random teleport within a spell_range
	var target = owner.detection_area.current_target
	var random_offset = Vector2(randf_range(-200, 200), randf_range(-200, 200))

	if target:
		owner.global_position = target.global_position + random_offset
	else:
		owner.global_position += random_offset

	# Animation and SFX
	# owner.animation_player.play("teleport")

	state_machine.transition_to("Phase" + str(owner.current_phase))
