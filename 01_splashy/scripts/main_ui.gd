extends Control


signal start_game


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = %PlayButton


func _ready() -> void:
	play_button.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("enter") or Input.is_action_pressed("splash"):
		play_button.set_pressed(true)


func _on_play_button_pressed():
	play_button.set_disabled(true)
	anim.play("start_game")
	start_game.emit()
	await anim.animation_finished
	hide()


func _on_exit_button_pressed():
	get_tree().quit()

