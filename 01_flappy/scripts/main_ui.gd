extends Control


signal start_game


func _ready() -> void:
	%PlayButton.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("enter") or Input.is_action_pressed("splash"):
		%PlayButton.set_pressed(true)


func _on_play_button_pressed():
	%PlayButton.set_disabled(true)
	$AnimationPlayer.play("start_game")
	start_game.emit()
	await $AnimationPlayer.animation_finished
	hide()


func _on_exit_button_pressed():
	get_tree().quit()

