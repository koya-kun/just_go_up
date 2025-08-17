extends Area2D

var y_speed: float = 100
var x_speed: float
var player_dir: int = 1
var lifetime: float = 10
var dead: bool = false

func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
	if get_parent().player_ref.position.x - position.x > 0:
		player_dir = 1
	else:
		player_dir = -1
	x_speed = randf_range(-20, 250)
	position.y -= y_speed / get_parent().speed_multiplier * delta
	if !dead:
		position.x += x_speed * delta * player_dir
	

func _on_area_entered(area: Area2D) -> void:
	$CollisionShape2D.set_process(false)
	y_speed = -200
	dead = true


func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().root.get_child(0).player_ref:
		get_parent().game_over = true
