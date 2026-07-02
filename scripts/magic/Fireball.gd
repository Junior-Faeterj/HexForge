extends SpellBase

@export var speed: float = 400.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(_body: Node) -> void:
	_on_impact()
