extends Node


var game_res: PackedScene = preload("res://scenes/game/game.tscn")


func _on_main_ui_start_game():
	%World.add_child(game_res.instantiate())


func show_fake_character() -> void:
	%FakeCharacter.show()


func hide_fake_character() -> void:
	%FakeCharacter.hide()

