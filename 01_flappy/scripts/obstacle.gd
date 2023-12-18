extends AnimatableBody2D


var tween: Tween

var start_pos: Vector2
var end_pos: Vector2


func _ready() -> void:
	start_pos = Vector2(692.0, 480.0)
	end_pos   = Vector2(-52.0, 480.0)
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_pos, 2.0)
	tween.tween_callback(reset)


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	pass


func move() -> void:
	pass


func reset() -> void:
	set_position(start_pos)

