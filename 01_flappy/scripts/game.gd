extends Node


signal game_restart


@export var diff: float = 960.0 / 2


var obstacle_res: PackedScene = preload("res://scenes/obstacle.tscn")

var last_height: float = 480.0


func _ready() -> void:
	%GameUI.game_ready.connect(%Character._game_ready)
	%GameUI.game_ready.connect(_game_ready)
	%GameUI.game_restart.connect(%Character._game_restart)
	%GameUI.game_restart.connect(_game_restart)


func start_obstacles() -> void:
	var obstacle = obstacle_res.instantiate()
	obstacle.position.y = randf_range(440.0, 500.0)
	obstacle.increase_score.connect(%GameUI._on_increase_score)
	obstacle.spawn_next.connect(spawn_obstacle)
	obstacle.body_entered.connect(%Character._on_obstacle_body_entered)
	%Obstacles.add_child(obstacle)


func spawn_obstacle() -> void:
	var height: float = randf_range(200.0, 648.0)
	
	# Make sure the difference isn't too big when going up
	if (height - last_height) > 300.0:
		#print("\nTOO HIGH")
		height = last_height + 200.0
	
	# Make sure the difference isn't too small in either direction
	var height_diff = height - last_height
	#print(str(height_diff))
	if height_diff < 0.0 and height_diff > -100.0:
		#print("TOO CLOSE (BELOW)")
		height = last_height - 300.0
	elif height_diff >= 0.0 and height_diff < 100.0:
		#print("TOO CLOSE (ABOVE)")
		height = last_height + 200.0
	
	height = clampf(height, 200.0, 648.0)
	last_height = height
	
	var obstacle: Area2D = obstacle_res.instantiate()
	obstacle.position.y = height
	obstacle.increase_score.connect(%GameUI._on_increase_score)
	obstacle.spawn_next.connect(spawn_obstacle)
	obstacle.body_entered.connect(%Character._on_obstacle_body_entered)
	%Obstacles.add_child(obstacle)


func _game_ready() -> void:
	start_obstacles() 
	get_parent().get_parent().hide_fake_character()


func _game_restart() -> void:
	game_restart.emit()

