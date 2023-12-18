extends Node


@export var diff: float = 960.0 / 2


var obstacle_res: PackedScene = preload("res://scenes/obstacle.tscn")

var last_height: float = 480.0


func _ready() -> void:
	var obstacle = obstacle_res.instantiate()
	obstacle.position.y = randf_range(440.0, 500.0)
	obstacle.spawn_next.connect(_on_obstacle_spawn_next)
	obstacle.body_entered.connect(%Character._on_obstacle_body_entered)
	add_child(obstacle)


func _on_obstacle_spawn_next() -> void:
	spawn_obstacle()


func spawn_obstacle() -> void:
	var height: float = randf_range(200.0, 648.0)
	#print("height: " + str(height) + "   last_height: " + str(last_height) + "   diff: " + str(height - last_height))
	
	# Make sure the difference isn't too big when going up
	if (height - last_height) > 200.0:
		height = last_height + 100.0
	
	# Make sure the difference isn't too small either way
	if (height - last_height) < 0.0:
		height -= 60.0
	else:
		height += 60.0
	
	height = clampf(height, 200.0, 648.0)
	
	last_height = height
	var obstacle: Area2D = obstacle_res.instantiate()
	obstacle.position.y = height
	obstacle.spawn_next.connect(_on_obstacle_spawn_next)
	obstacle.body_entered.connect(%Character._on_obstacle_body_entered)
	add_child(obstacle)

