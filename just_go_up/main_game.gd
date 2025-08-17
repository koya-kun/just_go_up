extends Node2D

func _ready() -> void:
	start_title()

func start_game():
	var _children = get_children()
	for child in _children:
		child.queue_free()
	var game = preload('res://main_scene.tscn').instantiate()
	add_child(game)

func start_title():
	var _children = get_children()
	for child in _children:
		child.queue_free()
	var title = preload('res://start_menu.tscn').instantiate()
	add_child(title)
	
