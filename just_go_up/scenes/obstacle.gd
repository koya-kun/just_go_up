extends Area2D

var speed: float = 130
var dir: float
var x_speed: float = 30

func _ready() -> void:
	dir = randf_range(-1, 1)


func _process(delta: float) -> void:
	if dir < 0:
		position.x += x_speed * delta
	else:
		$Sprite2D.flip_h = true
		position.x -= x_speed * delta
	position.y += speed * delta * get_parent().speed_multiplier
	if position.y > 350:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().root.get_child(0).get_child(0).player_ref:
		get_parent().game_over = true
		
