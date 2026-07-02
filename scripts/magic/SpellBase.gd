extends Node2D
class_name SpellBase

## SpellBase
## Base class for all instantiated magic effects.

@export var resource: Resource # Use base Resource to avoid circularity with MagicResource
@onready var hitbox: Node = get_node_or_null("Hitbox") # Use Node to avoid circularity

var caster: Node2D
var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	if hitbox and resource:
		hitbox.attack_data.damage = resource.damage
		hitbox.attack_data.attacker = caster

	var timer := get_tree().create_timer(5.0)
	timer.timeout.connect(queue_free)

func init(init_caster: Node2D, init_direction: Vector2) -> void:
	caster = init_caster
	direction = init_direction
	look_at(global_position + direction)

## Common behavior for spells when they "hit" something.
func _on_impact() -> void:
	queue_free()
