extends SpellBase

func _ready() -> void:
	super._ready()
	$AnimationPlayer.play("explode")
	$AnimationPlayer.animation_finished.connect(func(_name): queue_free())

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
