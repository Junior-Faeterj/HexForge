extends State

func enter(_msg := {}) -> void:
	owner.animation.play_death()
	# Disable collisions or other logic
	owner.set_physics_process(false)

func physics_update(_delta: float) -> void:
	owner.movement.move(Vector2.ZERO)
