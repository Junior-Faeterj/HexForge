extends Node

## AudioManager
## Responsibility: Centralized control for music and sound effects with fade and persistence.

signal volume_changed(bus_name: String, value: float)

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var music_player_alt: AudioStreamPlayer = AudioStreamPlayer.new() # For cross-fades

var active_music_player: AudioStreamPlayer

func _ready() -> void:
	add_child(music_player)
	add_child(music_player_alt)
	music_player.bus = "Music"
	music_player_alt.bus = "Music"
	active_music_player = music_player

	# Load initial volumes
	_load_volumes()

func play_music(stream: AudioStream, fade_duration: float = 1.0) -> void:
	if active_music_player.stream == stream:
		return

	var next_player = music_player_alt if active_music_player == music_player else music_player
	next_player.stream = stream
	next_player.volume_db = -80
	next_player.play()

	var tween = create_tween().set_parallel(true)
	tween.tween_property(active_music_player, "volume_db", -80, fade_duration)
	tween.tween_property(next_player, "volume_db", 0, fade_duration)

	await tween.finished
	active_music_player.stop()
	active_music_player = next_player

func play_sfx(stream: AudioStream, position: Vector2 = Vector2.ZERO, loop: bool = false) -> void:
	var sfx_player = AudioStreamPlayer2D.new()
	sfx_player.stream = stream
	sfx_player.position = position
	sfx_player.bus = "SFX"
	add_child(sfx_player)

	# Loop settings in Godot 4 are often on the stream itself,
	# but we can simulate or check for loop properties.
	sfx_player.play()

	if not loop:
		sfx_player.finished.connect(sfx_player.queue_free)

func set_bus_volume(bus_name: String, linear_value: float) -> void:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx != -1:
		AudioServer.set_bus_volume_db(bus_idx, linear_to_db(linear_value))
		volume_changed.emit(bus_name, linear_value)
		_save_volumes()

func _load_volumes() -> void:
	var config = SaveManager.load_config()
	set_bus_volume("Master", config.get("volume_Master", 0.8))
	set_bus_volume("Music", config.get("volume_Music", 0.8))
	set_bus_volume("SFX", config.get("volume_SFX", 0.8))

func _save_volumes() -> void:
	var config = SaveManager.load_config()
	config["volume_Master"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	config["volume_Music"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	config["volume_SFX"] = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	SaveManager.save_config(config)
