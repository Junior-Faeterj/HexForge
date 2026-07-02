extends Control

func _on_back_pressed() -> void:
	hide()

func _on_volume_changed(value: float, bus_index: int) -> void:
	var bus_name = AudioServer.get_bus_name(bus_index)
	AudioManager.set_bus_volume(bus_name, value)
