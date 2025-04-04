extends Area2D


signal spawn_next
signal increase_score


@export var scroll_speed: float = 5.4
@export var position_to_spawn_next_obstacle: float = 340.0  # higher means spawned earlier (harder)


var tween: Tween

var start_pos: Vector2
var end_pos: Vector2

var spawned_next: bool
var scored: bool


func _ready() -> void:
	scored = false
	
	var height: float = position.y
	
	start_pos = Vector2(696.0, height)
	end_pos   = Vector2(-56.0, height)
	spawned_next = false
	
	set_position(start_pos)


func _physics_process(_delta: float) -> void:
	position.x -= scroll_speed
	
	if not spawned_next and position.x <= position_to_spawn_next_obstacle:
		spawn_next.emit()
		spawned_next = true
	if not scored and position.x <= 176.0:  # character.pos.x - (obstacle.width / 2) + wiggle_room(20)           
		increase_score.emit()
		scored = true
