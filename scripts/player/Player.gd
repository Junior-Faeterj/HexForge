extends CharacterBody2D
class_name Player

## Player
## Central hub for player components. Assembly of functionality.

@onready var input: PlayerInput = $Components/Input
@onready var movement: PlayerMovement = $Components/Movement
@onready var animation: PlayerAnimation = $Components/Animation
@onready var health: PlayerHealth = $Components/Health
@onready var mana: PlayerMana = $Components/Mana
@onready var level: PlayerLevel = $Components/Level
@onready var spells: SpellManager = $Components/Spells
@onready var fsm: PlayerFSM = $FSM

@export var stats: PlayerStats

func _ready() -> void:
	# Initialize components with stats if provided
	if stats:
		health.max_health = stats.max_health
		mana.max_mana = stats.max_mana
		movement.speed = stats.base_speed

	health.health_depleted.connect(_on_death)

func _process(delta: float) -> void:
	# Handle regeneration
	if stats:
		health.regenerate(stats.health_regen_rate * delta)
		mana.regenerate(stats.mana_regen_rate * delta)

func _on_death() -> void:
	fsm.transition_to("Death")

## Interface for receiving damage
func take_damage(amount: float) -> void:
	health.take_damage(amount)
