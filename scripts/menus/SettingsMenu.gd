extends Control

func _on_back_pressed() -> void:
	hide()

func _on_volume_changed(value: float, bus_index: int) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	# Save config
	var config = SaveManager.load_config()
	config["volume_" + str(bus_index)] = value
	SaveManager.save_config(config)
