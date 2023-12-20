extends Node


var best: int


func _ready() -> void:
	load_best()


func load_best() -> void:
	# Check if file exists
	if not FileAccess.file_exists("user://best.save"):
		best = 0
		print("ERROR: Save file does not exist.")
		return
	
	var save_file := FileAccess.open("user://best.save", FileAccess.READ)
	best = int(save_file.get_line())
	save_file.close()


func save_score(score: int) -> void:
	if score <= best:
		return
	
	best = score
	
	var save_file := FileAccess.open("user://best.save", FileAccess.WRITE)
	save_file.store_line(str(score))
	save_file.close()


func get_best() -> int:
	return best

