extends Area2D


signal spawn_next
signal increase_score


@export var seconds_to_travel_across_screen: float = 2.3    # lower means faster (harder)
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
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_pos, \
			seconds_to_travel_across_screen)
	tween.tween_callback(queue_free)


func _process(_delta: float) -> void:
	if not spawned_next and position.x <= position_to_spawn_next_obstacle:
		spawn_next.emit()
		spawned_next = true
	if not scored and position.x <= 176.0:  # character.pos.x - (obstacle.width / 2) + wiggle_room(20)
		increase_score.emit()
		scored = true

