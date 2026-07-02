extends State

func enter(_msg: Dictionary = {}) -> void:
	# Alert animation or pause
	# owner.animation_player.play("detect")
	await get_tree().create_timer(0.5).timeout
	state_machine.transition_to("Follow")
