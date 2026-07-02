extends State

var _summon_timer: float = 0.0

func enter(_msg: Dictionary = {}) -> void:
	_summon_timer = owner.boss_stats.summon_cooldown

func update(delta: float) -> void:
	_summon_timer -= delta
	if _summon_timer <= 0:
		state_machine.transition_to("Summon")
		_summon_timer = owner.boss_stats.summon_cooldown
