extends Control
class_name HUD

## HUD
## Main controller for the game overlay UI.

@onready var health_bar: ProgressBar = $Bars/HealthBar
@onready var mana_bar: ProgressBar = $Bars/ManaBar
@onready var xp_label: Label = $Info/XPLabel
@onready var level_label: Label = $Info/LevelLabel
@onready var fps_label: Label = $Debug/FPSLabel

@onready var game_over_screen: Control = $Screens/GameOverScreen
@onready var victory_screen: Control = $Screens/VictoryScreen
@onready var pause_menu: Control = $Screens/PauseMenu

func _ready() -> void:
	# Try to find player, otherwise wait
	var player = get_tree().get_first_node_in_group("player")
	if player:
		_setup_player_connections(player)
	else:
		# Fallback: wait a frame or until player is added to tree
		get_tree().node_added.connect(_on_node_added)

	GameManager.game_over.connect(_on_game_over)
	GameManager.victory.connect(_on_victory)

	game_over_screen.hide()
	victory_screen.hide()
	pause_menu.hide()

func _on_node_added(node: Node) -> void:
	if node is Player:
		_setup_player_connections(node)
		get_tree().node_added.disconnect(_on_node_added)

func _setup_player_connections(player: Player) -> void:
	player.health.health_changed.connect(_on_health_changed)
	player.mana.mana_changed.connect(_on_mana_changed)
	player.level.xp_changed.connect(_on_xp_changed)
	player.level.level_up.connect(_on_level_up)
	# Initialize values
	_on_health_changed(player.health.current_health, player.health.max_health)
	_on_mana_changed(player.mana.current_mana, player.mana.max_mana)
	_on_xp_changed(player.level.current_xp, player.level.get_next_level_requirement())
	_on_level_up(player.level.current_level)

func _process(_delta: float) -> void:
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

func _on_health_changed(current: float, max_val: float) -> void:
	health_bar.max_value = max_val
	health_bar.value = current

func _on_mana_changed(current: float, max_val: float) -> void:
	mana_bar.max_value = max_val
	mana_bar.value = current

func _on_xp_changed(current: int, next_level_xp: int) -> void:
	xp_label.text = "XP: %d / %d" % [current, next_level_xp]

func _on_level_up(new_level: int) -> void:
	level_label.text = "Level: " + str(new_level)

func _on_game_over() -> void:
	game_over_screen.show()

func _on_victory() -> void:
	victory_screen.show()
