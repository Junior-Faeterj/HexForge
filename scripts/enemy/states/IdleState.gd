extends State

@export var idle_time: float = 2.0
var _timer: float = 0.0

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	_timer = idle_time
	# owner.animation_player.play("idle")

func update(delta: float) -> void:
	_timer -= delta
	if _timer <= 0:
		state_machine.transition_to("Patrol")

	if owner.detection_area.is_target_in_range():
		state_machine.transition_to("Detect")
