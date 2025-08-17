extends Node2D

@export var obstacles: Array[PackedScene]
var obstacle_spawn_time: float = 2
var obstacle_spawn_timer: float = 2
var speed_multiplier: float = 1
var game_over: bool = false
var player_ref: CharacterBody2D

func _ready() -> void:
	player_ref = $player

func _process(delta: float) -> void:
	obstacle_spawn_timer -= delta
	if obstacle_spawn_timer <= 0:
		obstacle_spawn_timer = obstacle_spawn_time - speed_multiplier
		var _obstacle = obstacles[randi() % obstacles.size()].instantiate()
		_obstacle.position.y = 0
		_obstacle.position.x = randi() % 1000
		add_child(_obstacle)
	if game_over:
		print("game over")
