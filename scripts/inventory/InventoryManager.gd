extends Node
class_name InventoryManager

## InventoryManager
## Handles logic for item storage, stacking, and persistence.

signal inventory_updated

@export var slot_count: int = 20
var slots: Array[Dictionary] = []

func _ready() -> void:
	_initialize_slots()

func _initialize_slots() -> void:
	slots.clear()
	for i in range(slot_count):
		slots.append({"item": null, "quantity": 0})

func add_item(item: ItemResource, quantity: int = 1) -> bool:
	if item.stackable:
		# Find existing stack
		for slot in slots:
			if slot.item and slot.item.id == item.id and slot.quantity < item.max_stack:
				var space: int = item.max_stack - slot.quantity
				var to_add: int = min(space, quantity)
				slot.quantity += to_add
				quantity -= to_add
				if quantity <= 0:
					inventory_updated.emit()
					return true

	# Find empty slot
	while quantity > 0:
		var empty_slot: Dictionary = _find_empty_slot()
		if not empty_slot.is_empty():
			var to_add: int = min(item.max_stack if item.stackable else 1, quantity)
			empty_slot.item = item
			empty_slot.quantity = to_add
			quantity -= to_add
		else:
			inventory_updated.emit()
			return false # Inventory full

	inventory_updated.emit()
	return true

func _find_empty_slot() -> Dictionary:
	for slot in slots:
		if slot.item == null:
			return slot
	return {}

func swap_slots(index1: int, index2: int) -> void:
	if index1 < 0 or index1 >= slots.size() or index2 < 0 or index2 >= slots.size():
		return
	var temp: Dictionary = slots[index1]
	slots[index1] = slots[index2]
	slots[index2] = temp
	inventory_updated.emit()

func get_save_data() -> Array:
	var data: Array = []
	for slot: Dictionary in slots:
		if slot.item:
			data.append({"id": slot.item.id, "quantity": slot.quantity})
		else:
			data.append(null)
	return data

func load_save_data(data: Array, item_database: Dictionary) -> void:
	_initialize_slots()
	for i: int in range(min(data.size(), slots.size())):
		if data[i]:
			var item: ItemResource = item_database.get(data[i].id) as ItemResource
			if item:
				slots[i].item = item
				slots[i].quantity = data[i].quantity
	inventory_updated.emit()
