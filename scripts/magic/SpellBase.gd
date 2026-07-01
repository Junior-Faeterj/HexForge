extends Node2D
class_name SpellBase

## SpellBase
## Base class for all instantiated magic effects (projectiles, AOEs, etc.).

@export var resource: MagicResource

var caster: Node2D
var direction: Vector2 = Vector2.RIGHT
var damage: float = 0.0

func _ready() -> void:
	if resource:
		damage = resource.damage

	# Auto-destroy after range/lifetime
	var timer := get_tree().create_timer(5.0)
	timer.timeout.connect(queue_free)

func init(init_caster: Node2D, init_direction: Vector2) -> void:
	caster = init_caster
	direction = init_direction
	look_at(global_position + direction)

func _on_hit(body: Node) -> void:
	# Combat logic will be expanded in the Combat System module
	if body.has_method("take_damage"):
		body.take_damage(damage)

	# Standard behavior: destroy on impact unless pierced
	queue_free()
