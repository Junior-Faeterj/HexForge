extends SpellBase

@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(_body: Node) -> void:
	# Damage is handled by the Hitbox component.
	# We just handle projectile impact logic here.
	_on_impact()
