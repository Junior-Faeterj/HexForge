extends SpellBase

func _ready() -> void:
	super._ready()
	if $AnimationPlayer:
		$AnimationPlayer.play("explode")
		$AnimationPlayer.animation_finished.connect(func(_name): queue_free())

func _on_body_entered(_body: Node) -> void:
	# Damage is handled by the Hitbox component.
	pass
