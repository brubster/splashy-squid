extends Control


var score: int


func _ready() -> void:
	score = 0
	update_score_label()


func _on_increase_score() -> void:
	score += 1
	update_score_label()


func update_score_label() -> void:
	%Score.set_text(str(score))

