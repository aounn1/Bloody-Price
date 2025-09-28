extends Area2D

@export var damage: int = 10  # 10% damage

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"): # add your player to "Player" group
		body.take_damage(damage)
