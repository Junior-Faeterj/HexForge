extends Node
class_name SpellManager

## SpellManager
## Manages spell inventory, casting, cooldowns, and mana costs.

signal spell_cast(spell_resource: MagicResource)
signal cooldown_updated(spell_resource: MagicResource, remaining: float)

@export var spells: Array[MagicResource] = []
@onready var player: Player = owner

var cooldowns: Dictionary[String, float] = {}
var _spell_cache: Dictionary[String, MagicResource] = {}

func _ready() -> void:
	for spell in spells:
		_spell_cache[spell.name] = spell

func _process(delta: float) -> void:
	for spell_name in cooldowns.keys():
		if cooldowns[spell_name] > 0:
			cooldowns[spell_name] -= delta
			var res = _spell_cache.get(spell_name)
			if res:
				cooldown_updated.emit(res, cooldowns[spell_name])

func cast_spell(index: int, direction: Vector2) -> void:
	if index < 0 or index >= spells.size():
		return

	var spell_res := spells[index]

	if is_on_cooldown(spell_res.name):
		return

	if player.mana.consume(spell_res.mana_cost):
		_execute_cast(spell_res, direction)
		_start_cooldown(spell_res)
		spell_cast.emit(spell_res)

func is_on_cooldown(spell_name: String) -> bool:
	return cooldowns.get(spell_name, 0.0) > 0

func _start_cooldown(spell_res: MagicResource) -> void:
	cooldowns[spell_res.name] = spell_res.cooldown

func _execute_cast(spell_res: MagicResource, direction: Vector2) -> void:
	if not spell_res.projectile_scene:
		return

	var spell_instance := spell_res.projectile_scene.instantiate() as SpellBase

	# Set properties BEFORE adding to tree to avoid _ready issues
	spell_instance.caster = player
	spell_instance.direction = direction
	spell_instance.global_position = player.global_position

	get_tree().root.add_child(spell_instance)

	# init handles looking at direction
	spell_instance.init(player, direction)

	if spell_res.cast_sfx:
		AudioManager.play_sfx(spell_res.cast_sfx, player.global_position)
