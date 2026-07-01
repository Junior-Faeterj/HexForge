extends Label
class_name DamageText

## DamageText
## Visual feedback for damage dealt.

func setup(amount: float, is_critical: bool) -> void:
	text = str(floor(amount))

	if is_critical:
		scale = Vector2(1.5, 1.5)
		modulate = Color.YELLOW
		text += "!"
	else:
		modulate = Color.WHITE

func _ready() -> void:
	# Animation logic
	var tween := create_tween().set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 40, 0.8).set_trans(Tween.TRANS_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.8).set_delay(0.2)
	tween.finished.connect(queue_free)
