extends Node
class_name PlayerMana

## PlayerMana
## Handles Mana management and regeneration.

signal mana_changed(current: float, max: float)
signal mana_depleted

@export var max_mana: float = 50.0:
	set(value):
		max_mana = value
		if current_mana > max_mana:
			current_mana = max_mana
		mana_changed.emit(current_mana, max_mana)

var current_mana: float = 50.0

func _ready() -> void:
	current_mana = max_mana
	mana_changed.emit(current_mana, max_mana)

func consume(amount: float) -> bool:
	if current_mana >= amount:
		current_mana -= amount
		mana_changed.emit(current_mana, max_mana)
		return true
	return false

func regenerate(amount: float) -> void:
	if current_mana < max_mana:
		current_mana = clamp(current_mana + amount, 0, max_mana)
		mana_changed.emit(current_mana, max_mana)
