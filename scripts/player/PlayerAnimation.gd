extends Node
class_name PlayerAnimation

## PlayerAnimation
## Controls the Sprite2D and AnimationPlayer based on state and direction.

@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

var current_direction: Vector2 = Vector2.DOWN

func update_animation(direction: Vector2, is_moving: bool) -> void:
	if is_moving:
		current_direction = direction
		play_move()
	else:
		play_idle()

	_flip_sprite()

func play_idle() -> void:
	if animation_player:
		animation_player.play("idle")

func play_move() -> void:
	if animation_player:
		animation_player.play("move")

func play_death() -> void:
	if animation_player:
		animation_player.play("death")

func _flip_sprite() -> void:
	if sprite and current_direction.x != 0:
		sprite.flip_h = current_direction.x < 0
