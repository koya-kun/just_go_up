extends Control

var hover_time: float = 0.9
var hover_timer: float
var hover_speed: float = 10
var hover_dir: int = 1
func _process(delta: float) -> void:
		#hover pretty
	hover_timer -= delta
	if hover_timer <= 0:
		hover_timer = hover_time
		hover_dir *= -1
	$player_image.position.y += hover_speed * hover_dir * delta
	$title.position.y += hover_speed * hover_dir * delta
	$dragon_image.position.y += hover_speed * hover_dir * delta * -1 * 1.2


func _on_button_button_up() -> void:
	get_parent().start_game()


func _on_quit_button_button_up() -> void:
	get_tree().quit()
