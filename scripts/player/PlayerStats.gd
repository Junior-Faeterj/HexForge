extends Resource
class_name PlayerStats

## PlayerStats
## Resource to store base attributes and current state for the player.

@export_group("Base Attributes")
@export var max_health: float = 100.0
@export var max_mana: float = 50.0
@export var base_speed: float = 200.0
@export var base_attack_power: float = 10.0
@export var base_defense: float = 5.0

@export_group("Regeneration")
@export var mana_regen_rate: float = 2.0 # Per second
@export var health_regen_rate: float = 0.5 # Per second
