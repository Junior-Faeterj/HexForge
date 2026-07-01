extends Area2D
class_name Hurtbox

## Hurtbox
## Component that receives damage from Hitboxes.
## Manages invulnerability frames and knockback signals.

signal received_damage(data: AttackData)
signal received_knockback(force: Vector2)
signal invulnerability_changed(is_invulnerable: bool)

@export var i_frames_duration: float = 0.5

var is_invulnerable: bool = false:
	set(value):
		is_invulnerable = value
		invulnerability_changed.emit(is_invulnerable)

func take_attack(data: AttackData) -> bool:
	if is_invulnerable:
		return false

	# Trigger damage
	received_damage.emit(data)

	# Calculate knockback direction
	var kb_dir := (global_position - data.attack_position).normalized()
	received_knockback.emit(kb_dir * data.knockback_force)

	# Start I-frames
	_start_i_frames()

	return true

func _start_i_frames() -> void:
	is_invulnerable = true
	await get_tree().create_timer(i_frames_duration).timeout
	is_invulnerable = false
