extends EnemyStats
class_name BossStats

## BossStats
## Specialized stats for Boss entities including phase thresholds.

@export var phase2_threshold: float = 0.66 # 66% HP
@export var phase3_threshold: float = 0.33 # 33% HP

@export var teleport_cooldown: float = 5.0
@export var summon_cooldown: float = 12.0
@export var minion_scene: PackedScene
