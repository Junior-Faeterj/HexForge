extends EnemyBase
class_name Boss

## Boss
## Master controller for Boss entities. Handles phase detection.

signal phase_changed(new_phase: int)

@onready var boss_stats: BossStats = stats as BossStats
var current_phase: int = 1

func _ready() -> void:
	super._ready()
	if health_component:
		health_component.health_changed.connect(_on_health_changed)

func _on_health_changed(current: float, max_val: float) -> void:
	var hp_percent := current / max_val

	if current_phase == 1 and hp_percent <= boss_stats.phase2_threshold:
		_change_phase(2)
	elif current_phase == 2 and hp_percent <= boss_stats.phase3_threshold:
		_change_phase(3)

func _change_phase(new_phase: int) -> void:
	current_phase = new_phase
	phase_changed.emit(current_phase)

	# Transition FSM to appropriate phase state
	match current_phase:
		2: fsm.transition_to("Phase2")
		3: fsm.transition_to("Phase3")
