extends Area2D

var loose: bool = false
var drop_speed: float = 150

func _process(delta: float) -> void:
	if loose:
		position.y += drop_speed * delta
		drop_speed *= 1 + delta
		reparent(get_tree().root.get_child(0))


#func _on_body_entered(body: Node2D) -> void:
#	if body == get_tree().root.get_child(0).player_ref:
#		body.collect(new())
#		queue_free()
