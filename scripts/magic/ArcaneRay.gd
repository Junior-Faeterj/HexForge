extends SpellBase

@onready var line: Line2D = $Line2D
@onready var ray: RayCast2D = $RayCast2D

func _ready() -> void:
	super._ready()
	var timer: SceneTreeTimer = get_tree().create_timer(0.3)
	timer.timeout.connect(queue_free)

	if resource:
		ray.target_position = direction * (resource as MagicResource).spell_range
		ray.force_raycast_update()

		var end_point: Vector2 = ray.target_position
		if ray.is_colliding():
			end_point = to_local(ray.get_collision_point())
			var collider: Object = ray.get_collider()
			var hurtbox: Node = collider.get_node_or_null("Hurtbox")
			if hurtbox:
				var data: AttackData = AttackData.new()
				data.damage = resource.damage
				data.attacker = caster
				data.attack_position = global_position
				if hurtbox.has_method("take_attack"):
					hurtbox.take_attack(data)

		line.points = [Vector2.ZERO, end_point]
