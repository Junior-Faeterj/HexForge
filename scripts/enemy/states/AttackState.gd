extends State

func enter(_msg: Dictionary = {}) -> void:
	# owner.animation_player.play("attack")
	# Perform damage logic (Hitbox)
	await get_tree().create_timer(1.0).timeout
	state_machine.transition_to("Follow")

func physics_update(_delta: float) -> void:
	owner.velocity = Vector2.ZERO
