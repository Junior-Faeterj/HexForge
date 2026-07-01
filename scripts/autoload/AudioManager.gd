extends Node

## AudioManager
## Responsibility: Centralized control for music and sound effects playback.

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
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = stream
	sfx_player.position = position
	sfx_player.bus = "SFX"
	# Add to AudioManager instead of root for cleaner tree
	add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)
