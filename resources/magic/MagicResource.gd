extends Resource
class_name MagicResource

## MagicResource
## Defines the data for a spell. Data-driven approach for easy balancing.

@export var name: String = "Magic Bolt"
@export var description: String = ""
@export var mana_cost: float = 10.0
@export var cooldown: float = 1.0
@export var damage: float = 5.0
@export var spell_range: float = 200.0

@export var icon: Texture2D
@export var projectile_scene: PackedScene # The scene to instantiate
@export var cast_vfx: PackedScene
@export var cast_sfx: AudioStream
