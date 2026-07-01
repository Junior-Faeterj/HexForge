extends Node
class_name PlayerMovement

## PlayerMovement
## Handles the physics of player movement and knockback.

@export var player: CharacterBody2D
@export var speed: float = 200.0

var knockback_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * delta)
		player.velocity = knockback_velocity
		player.move_and_slide()

func move(direction: Vector2) -> void:
	if player and knockback_velocity.length() == 0:
		player.velocity = direction * speed
		player.move_and_slide()

func apply_knockback(force: Vector2) -> void:
	knockback_velocity = force
