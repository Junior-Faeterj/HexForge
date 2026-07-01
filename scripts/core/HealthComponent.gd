extends Node
class_name HealthComponent

## HealthComponent
## Generic component for managing health in entities, including regeneration.

signal health_changed(current: float, max: float)
signal health_depleted

@export var max_health: float = 100.0:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health
		health_changed.emit(current_health, max_health)

var current_health: float = 100.0

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func take_damage(amount: float) -> void:
	current_health = clamp(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		health_depleted.emit()

func heal(amount: float) -> void:
	current_health = clamp(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)

func regenerate(amount: float) -> void:
	if current_health < max_health and current_health > 0:
		heal(amount)
