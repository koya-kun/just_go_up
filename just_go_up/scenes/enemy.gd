extends Area2D

var y_speed: float = 200
var x_speed: float
var player_dir: int = 1
var lifetime: float = 10
var dead: bool = false
var squish_time: float = 0.2
var squish_timer: float = 0

func _process(delta: float) -> void:
	if squish_timer > 0:
		squish_timer -= delta
		if squish_timer >= squish_time / 2:
			scale -= Vector2(0.07, 0.07)
		else:
			scale += Vector2(0.07, 0.07)
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
	y_speed = -300
	$Sprite2D.flip_v = true
	squish_timer = squish_time
	dead = true


func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().root.get_child(0).get_child(0).player_ref:
		get_parent().game_over = true
