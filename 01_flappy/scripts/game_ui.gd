extends Control


signal game_ready


var score: int

var first_input: bool


func _ready() -> void:
	first_input = false
	show()
	%Anim.set_speed_scale(1.0)
	%Anim.play("game_ui_fade_in")
	score = 0
	update_score_label()


func _process(_delta: float) -> void:
	if not first_input and Input.is_action_just_pressed("flap"):
		first_input = true
		game_ready.emit()
		%AnimFadeOut.set_speed_scale(6.0)
		%AnimFadeOut.play("ready_ui_fade_out")
		await %AnimFadeOut.animation_finished
		%ReadyMargin.hide()


func _on_increase_score() -> void:
	score += 1
	update_score_label()


func update_score_label() -> void:
	%Score.set_text(str(score))


func _on_character_death_flash():
	$DeathFlash.show()
	%Anim.set_speed_scale(2.0)  
	%Anim.play("death_flash")
	print("score: " + str(score))
 
