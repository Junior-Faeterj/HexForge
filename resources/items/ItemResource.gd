extends Resource
class_name ItemResource

## ItemResource
## Base class for all inventory items.

enum ItemType { POTION, SCROLL, CRYSTAL, EQUIPMENT }

@export var name: String = "Item"
@export var type: ItemType = ItemType.POTION
@export var description: String = ""
@export var icon: Texture2D
@export var stackable: bool = true
@export var value: int = 10

func use(target: Node) -> void:
	# Virtual method to be overridden by specific items
	pass
