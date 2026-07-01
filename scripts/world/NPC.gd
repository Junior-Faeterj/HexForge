extends CharacterBody2D
class_name NPC

## NPC
## Base class for friendly non-player characters.

@export var npc_name: String = "Stranger"
@export_multiline var dialogue: Array[String] = ["Greetings, traveler."]

func interact() -> void:
	# Dialogue logic would go here
	print(npc_name + ": " + dialogue[0])
