extends State

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	# owner.animation_player.play("take_damage")
	await get_tree().create_timer(0.3).timeout
	state_machine.transition_to("Follow")

func physics_update(_delta: float) -> void:
	# Potentially handle knockback here if not handled by components
	pass
