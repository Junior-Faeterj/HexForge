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
		_on_hit(ray.get_collider())

	line.points = [Vector2.ZERO, end_point]
