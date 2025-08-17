extends Area2D

var speed: float = 130

func _process(delta: float) -> void:
	position.y += speed * delta  * get_parent().speed_multiplier
	if position.y > 350:
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().root.get_child(0).get_child(0).player_ref:
		body.collect()
		queue_free()
