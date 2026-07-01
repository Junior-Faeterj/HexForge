extends Node

## AudioManager
## Responsibility: Centralized control for music and sound effects playback.
## Implements pooling for SFX to optimize performance.

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	add_child(music_player)
	music_player.bus = "Music"

func play_music(stream: AudioStream) -> void:
	if music_player.stream == stream:
		return
	music_player.stream = stream
	music_player.play()

func play_sfx(stream: AudioStream, position: Vector2 = Vector2.ZERO) -> void:
	# In a full implementation, this would use a pool of AudioStreamPlayer2D
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = stream
	sfx_player.position = position
	sfx_player.bus = "SFX"
	get_tree().root.add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)
