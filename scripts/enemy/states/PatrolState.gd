extends State

@export var patrol_radius: float = 100.0
var _target_pos: Vector2

func enter(_msg: Dictionary = {}) -> void:
	_target_pos = owner.global_position + Vector2(randf_range(-patrol_radius, patrol_radius), randf_range(-patrol_radius, patrol_radius))

func physics_update(_delta: float) -> void:
	var dir: Vector2 = (_target_pos - owner.global_position).normalized()
	owner.velocity = dir * owner.stats.movement_speed * 0.5
	owner.move_and_slide()

	if owner.global_position.distance_to(_target_pos) < 10.0:
		state_machine.transition_to("Idle")

	if owner.detection_area.is_target_in_range():
		state_machine.transition_to("Detect")
