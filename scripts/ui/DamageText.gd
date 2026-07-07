extends Node2D
class_name DamageText

## DamageText
## Visual feedback for damage dealt in world space.

@onready var label: Label = $Label

func setup(amount: float, is_critical: bool) -> void:
	label.text = str(floor(amount))

	if is_critical:
		label.scale = Vector2(1.5, 1.5)
		label.modulate = Color.YELLOW
		label.text += "!"
	else:
		label.modulate = Color.WHITE

func _ready() -> void:
	var tween: Tween = create_tween().set_parallel(true)
	tween.tween_property(self, "position:y", position.y - 40, 0.8).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.8).set_delay(0.2)
	tween.finished.connect(queue_free)
