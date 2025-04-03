extends Control


signal start_game


@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var play_button: BaseButton = %PlayButton


func _on_play_button_pressed():
	play_button.set_disabled(true)
	anim.play("start_game")
	start_game.emit()
	await anim.animation_finished
	hide()
