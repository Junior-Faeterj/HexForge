extends State

var _teleport_timer: float = 0.0

func enter(_msg: Dictionary[String, Variant] = {}) -> void:
	_teleport_timer = owner.boss_stats.teleport_cooldown

func update(delta: float) -> void:
	_teleport_timer -= delta
	if _teleport_timer <= 0:
		state_machine.transition_to("Teleport")
		_teleport_timer = owner.boss_stats.teleport_cooldown
