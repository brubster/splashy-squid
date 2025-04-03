extends Node


@onready var restart_fade: ColorRect = $RestartFade
@onready var world: Node = %World
@onready var fake_character: AnimatedSprite2D = %FakeCharacter
@onready var anim: AnimationPlayer = $Anim

var game_res: PackedScene


func _ready() -> void:
	game_res = preload("res://scenes/game.tscn")


func _on_main_ui_start_game():
	var game = game_res.instantiate()
	game.game_restart.connect(_game_restart)
	world.add_child(game)


func _game_restart() -> void:
	restart_fade.show()
	world.get_child(0).queue_free()
	anim.play("fade_to_transparent")
	_on_main_ui_start_game()
	show_fake_character()
	get_tree().set_pause(false)
	anim.seek(0.0)  # necessary to prevent screen flashing


func show_fake_character() -> void:
	fake_character.show()


func hide_fake_character() -> void:
	fake_character.hide()
