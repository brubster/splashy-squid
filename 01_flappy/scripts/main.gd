extends Node


var game_res: PackedScene


func _ready() -> void:
	game_res = preload("res://scenes/game.tscn")


func _on_main_ui_start_game():
	var game = game_res.instantiate()
	game.game_restart.connect(_game_restart)
	%World.add_child(game)


func _game_restart() -> void:
	get_tree().set_pause(false)
	%World.get_child(0).queue_free()
	show_fake_character() 
	_on_main_ui_start_game()
	$RestartFade.show()
	$Anim.play("fade_to_transparent")
	await $Anim.animation_finished
	$RestartFade.hide()


func show_fake_character() -> void:
	%FakeCharacter.show()


func hide_fake_character() -> void:
	%FakeCharacter.hide()

