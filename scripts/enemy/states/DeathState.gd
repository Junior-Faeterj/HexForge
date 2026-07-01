extends State

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	owner.animation_player.play("death")
	owner.set_physics_process(false)
	owner.hurtbox.set_deferred("monitoring", false)
	owner.hurtbox.set_deferred("monitorable", false)
