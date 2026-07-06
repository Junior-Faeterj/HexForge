extends Control
class_name InventoryUI

## InventoryUI
## Manages the grid of slots and interaction with InventoryManager.

@export var inventory_manager: InventoryManager
@onready var grid: GridContainer = $Background/Grid

const SLOT_SCENE = preload("res://scenes/ui/InventorySlot.tscn")

func _ready() -> void:
	if inventory_manager:
		inventory_manager.inventory_updated.connect(refresh_ui)
	_setup_grid()

func _setup_grid() -> void:
	# Clear existing
	for child in grid.get_children():
		child.queue_free()

	for i in range(inventory_manager.slot_count):
		var slot: InventorySlot = SLOT_SCENE.instantiate() as InventorySlot
		slot.slot_index = i
		grid.add_child(slot)

	refresh_ui()

func refresh_ui() -> void:
	var slots = inventory_manager.slots
	for i in range(slots.size()):
		var slot_ui: InventorySlot = grid.get_child(i) as InventorySlot
		slot_ui.update_slot(slots[i].item, slots[i].quantity)

func request_swap(from_index: int, to_index: int) -> void:
	inventory_manager.swap_slots(from_index, to_index)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_toggle"):
		visible = !visible
