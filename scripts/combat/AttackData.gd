extends Resource
class_name AttackData

## AttackData
## Container for passing attack information through the combat system.

@export var damage: float = 10.0
@export var knockback_force: float = 100.0
var attacker: Node2D = null
@export var is_critical: bool = false
@export var critical_multiplier: float = 2.0
@export var attack_position: Vector2
