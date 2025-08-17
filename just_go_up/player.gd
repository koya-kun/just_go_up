extends CharacterBody2D

var speed: float = 250
var weights: Array 
var weight_place_offset: float = 0
@export var sand_sack_scene: PackedScene

func _ready() -> void:
	collect()
	collect()

func _process(delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	if Input.is_action_pressed("right"):
		velocity.x = speed
	var hit = move_and_collide(velocity * delta)
	if hit:
		print("hit")
		if hit.get_collider().is_in_group("sacks"):
			print("collect")
			hit.get_collider().queue_free()
			collect()
	if Input.is_action_just_pressed("drop"):
		if weights.size() > 0:
			get_parent().speed_multiplier += 0.2
			speed *= get_parent().speed_multiplier
			weights[0].loose = true
			weights.pop_front()
	weight_place_offset = 0
	for weight in weights:
		weight.global_position = global_position
		weight.position.x += weight_place_offset - 30
		weight_place_offset += 15


func collect():
	var sack = sand_sack_scene.instantiate()
	get_parent().speed_multiplier -= 0.15
	weights.append(sack)
	sack.position = Vector2(30, 30)
	add_child(sack)
		
