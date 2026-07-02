extends Node2D
class_name AutoVFX

## AutoVFX
## Automatically frees the node after particles finish or a timer expires.

@export var auto_start: bool = true

func _ready() -> void:
	if auto_start:
		start()

func start() -> void:
	# Handle GPUParticles2D children
	for child in get_children():
		if child is GPUParticles2D:
			child.emitting = true
			child.finished.connect(_on_finished)

	# Fallback timer if no particles emit
	var timer = get_tree().create_timer(2.0)
	timer.timeout.connect(queue_free)

func _on_finished() -> void:
	# Optional: Check if all particle systems in children are done
	queue_free()
