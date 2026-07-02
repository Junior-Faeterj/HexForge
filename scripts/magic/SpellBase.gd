extends Node2D
class_name SpellBase

## SpellBase
## Base class for all instantiated magic effects.

@export var resource: Resource
@export var impact_vfx: PackedScene
@onready var hitbox: Node = get_node_or_null("Hitbox")

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

func _on_impact() -> void:
	if impact_vfx:
		var vfx = impact_vfx.instantiate()
		get_tree().root.add_child(vfx)
		vfx.global_position = global_position
	queue_free()
