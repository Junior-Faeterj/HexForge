extends SpellBase

func _ready() -> void:
	super._ready()
	var anim: AnimationPlayer = get_node_or_null("AnimationPlayer")
	if anim:
		anim.play("explode")
		anim.animation_finished.connect(func(_name): queue_free())

func _on_body_entered(_body: Node) -> void:
	pass
