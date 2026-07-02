extends Panel
class_name InventorySlot

## InventorySlot
## Handles visual display and Drag and Drop for individual slots.

@onready var icon: TextureRect = $Icon
@onready var quantity_label: Label = $Quantity

var slot_index: int = -1
var item: ItemResource = null

func update_slot(new_item: ItemResource, quantity: int) -> void:
	item = new_item
	if item:
		icon.texture = item.icon
		icon.show()
		quantity_label.text = str(quantity) if quantity > 1 else ""
		quantity_label.show()
	else:
		icon.texture = null
		icon.hide()
		quantity_label.hide()

func _get_drag_data(_at_position: Vector2) -> Variant:
	if item == null:
		return null

	var drag_preview := TextureRect.new()
	drag_preview.texture = item.icon
	drag_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	drag_preview.custom_minimum_size = Vector2(40, 40)
	set_drag_preview(drag_preview)

	return {"slot_index": slot_index, "item": item}

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Dictionary and data.has("slot_index")

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# Use find_parent to safely reach the InventoryUI regardless of GridContainer depth
	var inventory_ui = find_parent("InventoryUI") as InventoryUI
	if inventory_ui:
		inventory_ui.request_swap(data.slot_index, slot_index)
