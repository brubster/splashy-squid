extends Control


signal start_game


func _ready() -> void:
	%PlayButton.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("enter") or Input.is_action_pressed("flap"):
		%PlayButton.set_pressed(true)


func _on_play_button_pressed():
	%PlayButton.set_disabled(true)
	$AnimationPlayer.play("start_game")
	start_game.emit()

