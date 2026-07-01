extends CharacterBody2D
class_name Player

## Player
## Central hub for player components. Assembly of functionality.

@onready var input: PlayerInput = $Components/Input
@onready var movement: PlayerMovement = $Components/Movement
@onready var animation: PlayerAnimation = $Components/Animation
@onready var health: HealthComponent = $Components/Health
@onready var mana: PlayerMana = $Components/Mana
@onready var level: PlayerLevel = $Components/Level
@onready var spells: SpellManager = $Components/Spells
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var fsm: PlayerFSM = $FSM

@export var stats: PlayerStats

func _ready() -> void:
	add_to_group("player")

	if stats:
		health.max_health = stats.max_health
		mana.max_mana = stats.max_mana
		movement.speed = stats.base_speed

	health.health_depleted.connect(_on_death)
	hurtbox.received_damage.connect(_on_hurt)
	hurtbox.received_knockback.connect(_on_knockback)

func _process(delta: float) -> void:
	if stats:
		health.regenerate(stats.health_regen_rate * delta)
		mana.regenerate(stats.mana_regen_rate * delta)

func _on_hurt(data: AttackData) -> void:
	health.take_damage(data.damage)
	GameManager.spawn_damage_text(data.damage, global_position, data.is_critical)
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.RED, 0.1)
	tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.1)

func _on_knockback(force: Vector2) -> void:
	movement.apply_knockback(force)

func _on_death() -> void:
	fsm.transition_to("Death")
	GameManager.trigger_game_over()

func take_damage(amount: float) -> void:
	health.take_damage(amount)
