extends Area2D
class_name DetectionComponent

## DetectionComponent
## Handles player detection and proximity.

signal target_detected(target: Node2D)
signal target_lost

var current_target: Node2D = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		current_target = body
		target_detected.emit(body)

func _on_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null
		target_lost.emit()

func is_target_in_range() -> bool:
	return current_target != null
