extends Node
class_name PlayerMovement

## PlayerMovement
## Handles the physics of player movement.

@export var player: CharacterBody2D
@export var speed: float = 200.0

func move(direction: Vector2) -> void:
	if player:
		player.velocity = direction * speed
		player.move_and_slide()
