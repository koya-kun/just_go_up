extends Node2D

@export var obstacles: Array[PackedScene]
@export var enemy_scene: PackedScene
var obstacle_spawn_time: float = 2
var obstacle_spawn_timer: float
var enemy_spawn_time: float = 1
var enemy_spawn_timer: float
var speed_multiplier: float = 1.3
var game_over: bool = false
var player_ref: CharacterBody2D

func _ready() -> void:
	player_ref = $player
	obstacle_spawn_timer = obstacle_spawn_time
	enemy_spawn_timer = enemy_spawn_time

func _process(delta: float) -> void:
	get_child(0).autoscroll.y = int(150 * pow(speed_multiplier, 3))
	obstacle_spawn_timer -= delta
	enemy_spawn_timer -= delta
	if obstacle_spawn_timer <= 0:
		obstacle_spawn_timer = obstacle_spawn_time - speed_multiplier
		var _obstacle = obstacles[randi() % obstacles.size()].instantiate()
		_obstacle.position.y = -40
		_obstacle.position.x = randi() % 1000
		add_child(_obstacle)
	if enemy_spawn_timer <= 0:
		enemy_spawn_timer = enemy_spawn_time
		var _enemy = enemy_scene.instantiate()
		_enemy.position.y = 1000
		_enemy.position.x = randi() % 1000
		add_child(_enemy)
	if game_over:
		print("game over")
