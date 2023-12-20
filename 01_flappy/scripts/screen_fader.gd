extends Control


func _ready() -> void:
	hide()


func fade_to_black() -> void:
	show()
	set_mouse_filter(MouseFilter.MOUSE_FILTER_STOP)
	$AnimationPlayer.set_speed_scale(2.0)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("fade")


func fade_to_transparent() -> void:
	show()
	$AnimationPlayer.set_speed_scale(1.0)
	#$AnimationPlayer.stop()
	$AnimationPlayer.play_backwards("fade")
	set_mouse_filter(MouseFilter.MOUSE_FILTER_IGNORE)

