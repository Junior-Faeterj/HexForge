extends State

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	owner.animation.play_death()
	owner.set_physics_process(false)

func physics_update(_delta: float) -> void:
	owner.movement.move(Vector2.ZERO)
