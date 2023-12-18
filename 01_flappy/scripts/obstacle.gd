extends Area2D


signal spawn_next


var tween: Tween

var start_pos: Vector2
var end_pos: Vector2

var spawned_next: bool


func _ready() -> void:
	var height: float = position.y
	
	start_pos = Vector2(696.0, height)
	end_pos   = Vector2(-56.0, height)
	spawned_next = false
	
	set_position(start_pos)
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_pos, 2.4)
	tween.tween_callback(queue_free)


func _process(_delta: float) -> void:
	if not spawned_next and position.x <= 260.0:  # was 218.0
		spawn_next.emit()
		spawned_next = true

