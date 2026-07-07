extends Area2D
class_name Checkpoint

## Checkpoint
## Responsibility: Updates the player's saved position when triggered.

signal checkpoint_activated

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_activate()

func _activate() -> void:
	# Update save data manually or via SaveManager
	SaveManager.save_game()
	checkpoint_activated.emit()

	# Visual feedback
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.CYAN, 0.5)
