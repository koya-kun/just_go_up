extends CharacterBody2D

var speed: float = 300
var weights: Array 
var weight_place_offset: float = 0
var hover_time: float = 0.7
var hover_timer: float
var hover_speed: float = 10
var hover_dir: int = 1
var squish_time: float = 0.2
var squish_timer: float = 0
var og_size: Vector2
var amplitude: float = 0
@export var sand_sack_scene: PackedScene

func _ready() -> void:
	rotation = PI/4
	og_size = scale
	collect()

func _process(delta: float) -> void:
	#swinging
	#rotation -= delta
	rotation -= 30 * rotation * delta
	#hover pretty
	hover_timer -= delta
	if hover_timer <= 0:
		hover_timer = hover_time
		hover_dir *= -1
	position.y += hover_speed * hover_dir * delta
	# squish pretty
	if squish_timer > 0:
		squish_timer -= delta
		if squish_timer >= squish_time / 2:
			scale -= Vector2(0.07, 0.07)
		else:
			scale += Vector2(0.07, 0.07)
	else:
		scale = og_size
	# squish pretty ende
	velocity.x = 0
	if Input.is_action_pressed("left"):
		rotation = PI/8
		velocity.x = -speed
	if Input.is_action_pressed("right"):
		rotation = -PI/8
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
			weights[0].position.x += 25
			weights[0].loose = true
			weights.pop_front()
	weight_place_offset = 0
	for weight in weights:
		weight.global_position = global_position
		weight.position.x += weight_place_offset - 30
		weight_place_offset += 15


func collect():
	squish_timer = squish_time
	var sack = sand_sack_scene.instantiate()
	get_parent().speed_multiplier -= 0.18
	weights.append(sack)
#aa	sack.position = Vector2(30, 30)
	add_child(sack)
		
