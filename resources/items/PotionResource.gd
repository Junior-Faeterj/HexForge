extends ItemResource
class_name PotionResource

@export var heal_amount: float = 20.0
@export var mana_amount: float = 0.0

func use(target: Node) -> void:
	if target is Player:
		if heal_amount > 0: target.health.heal(heal_amount)
		if mana_amount > 0: target.mana.regenerate(mana_amount)
