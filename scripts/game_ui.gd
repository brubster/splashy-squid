extends Control


signal game_ready
signal game_restart


@onready var game_over_margin: Control = %GameOverMargin
@onready var anim: AnimationPlayer = %Anim
@onready var anim_fade_out: AnimationPlayer = %AnimFadeOut
@onready var pause_button: BaseButton = %PauseButton
@onready var play_button: BaseButton = %PlayButton


var score: int
var first_input: bool
var paused: bool


func _ready() -> void:
	first_input = false
	paused = false
	game_over_margin.hide()
	show()
	anim.set_speed_scale(1.0)
	anim.play("game_ui_fade_in")
	score = 0
	update_score_label()


func _unhandled_input(event: InputEvent) -> void:
	if paused:
		return
	if not first_input and event.is_action_pressed("splash"):
		first_input = true
		game_ready.emit()
		anim_fade_out.set_speed_scale(6.0)
		anim_fade_out.play("ready_ui_fade_out")
		await anim_fade_out.animation_finished
		%ReadyMargin.hide()


func _on_increase_score() -> void:
	score += 1
	update_score_label()


func update_score_label() -> void:
	%Score.set_text(str(score))


func _on_character_death_flash():
	# Death flash
	$DeathFlash.show()
	anim.set_speed_scale(2.0)  
	anim.play("death_flash")
	await anim.animation_finished
	
	# Save score
	Saver.save_score(score)
	
	# Game Over panel
	%ScoreLabel.set_text(str(score))
	%BestLabel.set_text(str(Saver.get_best()))
	game_over_margin.show()
	anim.play("game_over_reveal")
	await anim.animation_finished
 

func _on_restart_button_pressed(): 
	# Fade to black, reset game
	%RestartButton.set_disabled(true)
	$RestartFade.show()
	anim.play("restart_fade_to_black")
	await anim.animation_finished
	game_restart.emit()


func _on_exit_button_pressed():
	get_tree().quit()
 

func _on_pause_button_pressed():
	# In this case, the player has died, so the game should not get unpaused by the button
	if not paused and get_tree().is_paused():
		return
	switch_pause_buttons()
	paused = true
	get_tree().set_pause(true)


func _on_play_button_pressed():
	# In this case, the player has died, so the game should not get unpaused by the button
	if not paused and get_tree().is_paused():
		return
	switch_pause_buttons()
	paused = false
	get_tree().set_pause(false)


func switch_pause_buttons() -> void:
	if paused:
		play_button.hide()
		pause_button.show()
	else:
		pause_button.hide()
		play_button.show()

