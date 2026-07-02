extends Node
class_name HealthComponent

## HealthComponent
## Generic component for managing health in entities, including regeneration and flash feedback.

signal health_changed(current: float, max: float)
signal health_depleted

@export var max_health: float = 100.0:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health
		health_changed.emit(current_health, max_health)

var current_health: float = 100.0
var _owner_sprite: Sprite2D

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

	# Find parent's sprite for feedback
	if owner:
		_owner_sprite = owner.get_node_or_null("Sprite2D")

func take_damage(amount: float) -> void:
	current_health = clamp(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)

	_play_damage_flash()

	if current_health <= 0:
		health_depleted.emit()

func _play_damage_flash() -> void:
	if _owner_sprite:
		var tween = create_tween()
		tween.tween_property(_owner_sprite, "modulate", Color.RED, 0.05)
		tween.tween_property(_owner_sprite, "modulate", Color.WHITE, 0.05)

func heal(amount: float) -> void:
	current_health = clamp(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)

func regenerate(amount: float) -> void:
	if current_health < max_health and current_health > 0:
		heal(amount)
