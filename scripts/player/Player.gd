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
@onready var inventory: InventoryManager = $Components/Inventory
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var interact_ray: RayCast2D = $InteractionRay
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
	input.interact_requested.connect(_on_interact)

func _process(delta: float) -> void:
	if stats:
		health.regenerate(stats.health_regen_rate * delta)
		mana.regenerate(stats.mana_regen_rate * delta)

	# Update interaction ray direction
	if input.direction != Vector2.ZERO:
		interact_ray.target_position = input.direction * 30.0

func _on_hurt(data: AttackData) -> void:
	health.take_damage(data.damage)
	GameManager.spawn_damage_text(data.damage, global_position, data.is_critical)
	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color.RED, 0.1)
	tween.tween_property($Sprite2D, "modulate", Color.WHITE, 0.1)

func _on_knockback(force: Vector2) -> void:
	movement.apply_knockback(force)

func _on_interact() -> void:
	if interact_ray.is_colliding():
		var collider = interact_ray.get_collider()
		if collider.has_method("interact"):
			collider.interact()

func _on_death() -> void:
	fsm.transition_to("Death")
	GameManager.trigger_game_over()

func take_damage(amount: float) -> void:
	health.take_damage(amount)

func save() -> Dictionary[String, Variant]:
	return {
		"level": level.current_level,
		"xp": level.current_xp,
		"health": health.current_health,
		"mana": mana.current_mana,
		"position": [global_position.x, global_position.y],
		"inventory": inventory.get_save_data()
	}
