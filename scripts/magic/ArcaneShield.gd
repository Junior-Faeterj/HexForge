extends SpellBase

func _ready() -> void:
	# Shield attaches to caster
	if caster:
		if has_method("reparent"):
			reparent(caster)
		position = Vector2.ZERO

	var timer := get_tree().create_timer(3.0)
	timer.timeout.connect(queue_free)

func _process(_delta: float) -> void:
	pass
