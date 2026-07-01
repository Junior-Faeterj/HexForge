extends SpellBase

@onready var line := $Line2D
@onready var ray := $RayCast2D

func _ready() -> void:
	super._ready()
	# Beam is instantaneous but has a visual duration
	var timer := get_tree().create_timer(0.3)
	timer.timeout.connect(queue_free)

	ray.target_position = direction * resource.range
	ray.force_raycast_update()

	var end_point := ray.target_position
	if ray.is_colliding():
		end_point = to_local(ray.get_collision_point())
		var collider = ray.get_collider()
		# If the collider has a Hurtbox child
		var hurtbox = collider.get_node_or_null("Hurtbox")
		if hurtbox is Hurtbox:
			var data = AttackData.new()
			data.damage = resource.damage
			data.attacker = caster
			data.attack_position = global_position
			hurtbox.take_attack(data)

	line.points = [Vector2.ZERO, end_point]
