extends Area2D
class_name Hitbox

## Hitbox
## Component that deals damage to Hurtboxes.

signal hit_confirmed(hurtbox: Hurtbox)

@export var attack_data: AttackData = AttackData.new()
@export var critical_chance: float = 0.1 # 10% chance

func _ready() -> void:
	# Hitboxes usually only detect Hurtboxes
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var final_attack_data: AttackData = _prepare_attack_data()
		if (area as Hurtbox).take_attack(final_attack_data):
			hit_confirmed.emit(area)

func _prepare_attack_data() -> AttackData:
	var data: AttackData = AttackData.new()
	data.damage = attack_data.damage
	data.knockback_force = attack_data.knockback_force
	data.attacker = owner as Node2D
	data.attack_position = global_position

	# Calculate Critical
	if randf() < critical_chance:
		data.is_critical = true
		data.damage *= attack_data.critical_multiplier

	return data
