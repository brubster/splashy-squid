extends Control


signal game_ready
signal game_restart


@onready var game_over_margin: Control = %GameOverMargin
@onready var anim: AnimationPlayer = %Anim
@onready var anim_fade_out: AnimationPlayer = %AnimFadeOut


var score: int
var first_input: bool


func _ready() -> void:
	first_input = false
	game_over_margin.hide()
	show()
	anim.set_speed_scale(1.0)
	anim.play("game_ui_fade_in")
	score = 0
	update_score_label()


func _process(_delta: float) -> void:
	if not first_input and Input.is_action_just_pressed("splash"):
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
	%ScoreActual.set_text(str(score))
	%BestActual.set_text(str(Saver.get_best()))
	game_over_margin.show()
	anim.play("game_over_reveal")
	await anim.animation_finished
	%RestartButton.grab_focus()
 

func _on_restart_button_pressed(): 
	# Fade to black, reset game
	%RestartButton.set_disabled(true)
	$RestartFade.show()
	anim.play("restart_fade_to_black")
	await anim.animation_finished
	game_restart.emit()


func _on_exit_button_pressed():
	get_tree().quit()

