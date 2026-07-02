extends State

func enter(_msg: Dictionary = {}) -> void:
	# owner.animation_player.play("summon")

	if owner.boss_stats.minion_scene:
		for i in range(3):
			var minion = owner.boss_stats.minion_scene.instantiate()
			owner.get_parent().add_child(minion)
			minion.global_position = owner.global_position + Vector2(randf_range(-50, 50), randf_range(-50, 50))

	state_machine.transition_to("Phase" + str(owner.current_phase))
