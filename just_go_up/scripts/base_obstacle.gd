extends StaticBody2D

var speed: float = 130

func _process(delta: float) -> void:
	position.y += speed * delta * get_parent().speed_multiplier
	if position.y > 350:
		queue_free()
