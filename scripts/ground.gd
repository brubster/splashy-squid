extends StaticBody2D


@export var scroll_speed: float = 5.4


var floor1: Sprite2D
var floor2: Sprite2D

var start_pos: float = 792.0
var end_pos: float = -start_pos


func _ready() -> void:
	floor1 = $Floor1
	floor2 = $Floor2


func _physics_process(_delta: float) -> void:
	# Floor1
	floor1.position.x -= scroll_speed
	if floor1.position.x <= end_pos:
		floor1.position.x = start_pos
	
	# Floor2
	floor2.position.x -= scroll_speed
	if floor2.position.x <= end_pos:
		floor2.position.x = start_pos

