extends CharacterBody2D
class_name EnemyBase

## EnemyBase
## Base class for all enemies. Manages components and AI.

@export var stats: EnemyStats

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_component: HealthComponent = $Components/Health
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var detection_area: DetectionComponent = $DetectionArea
@onready var fsm: EnemyFSM = $FSM

func _ready() -> void:
	if stats:
		_apply_stats()

	if hurtbox:
		hurtbox.received_damage.connect(_on_hurt)

	if health_component:
		health_component.health_depleted.connect(_on_death)

func _apply_stats() -> void:
	if health_component:
		health_component.max_health = stats.max_health

	if detection_area:
		var shape: CollisionShape2D = detection_area.get_node("CollisionShape2D") as CollisionShape2D
		if shape and shape.shape is CircleShape2D:
			shape.shape.radius = stats.detection_range

func _on_hurt(data: AttackData) -> void:
	if health_component:
		health_component.take_damage(data.damage)
		GameManager.spawn_damage_text(data.damage, global_position, data.is_critical)
		_play_hit_feedback()

		# Transition to TakeDamage if alive
		if health_component.current_health > 0:
			fsm.transition_to("TakeDamage")

func _play_hit_feedback() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.RED, 0.1)
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)

func _on_death() -> void:
	fsm.transition_to("Death")
	# Drop XP or items logic would go here
	GameManager.add_xp(stats.xp_reward if stats else 0)
	# Basic destruction logic is handled by DeathState or an animation callback
