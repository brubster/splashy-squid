extends CharacterBody2D


signal death_flash


@export var gravity: float = 2000.0
@export var flap_velocity: float = -600.0


var input_allowed: bool
var is_dead: bool


func _ready() -> void:
	input_allowed = false
	is_dead = false
	set_physics_process(false)
	hide()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta
	
	# Die by the floor
	if is_on_floor():
		die_floor()
	
	if not is_dead:
		handle_rotation()
		handle_input()
	elif is_on_floor():
		# Prevent weird sliding after death animation
		set_physics_process(false)
	
	move_and_slide()


func handle_input() -> void:
	# Flap
	if Input.is_action_just_pressed("flap"):
		velocity.y = flap_velocity


func handle_rotation() -> void:
	var flap_lerp: float = lerpf(get_rotation_degrees(), (velocity.y * 0.5) - 100.0, 0.05)
	var flap_rotation: float = clampf(flap_lerp, -35.0, 85.0)
	set_rotation_degrees(flap_rotation)


# Die by an obstacle
func die() -> void:
	if is_dead:
		return
	
	death_flash.emit()
	velocity.y = flap_velocity  # final "flap", makes hit more impactful? TODO
	
	var tree = get_tree()
	tree.set_pause(true)
	
	is_dead = true
	
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.4)


# Die by the floor
func die_floor() -> void:
	if is_dead:
		return
	
	death_flash.emit()
	velocity.y = flap_velocity + 400.0
	
	var tree = get_tree()
	tree.set_pause(true)
	
	is_dead = true
	
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.05)


func _game_ready() -> void:
	set_input_allowed(true)
	show()
	set_physics_process(true)
	velocity.y = flap_velocity
	move_and_slide()


func set_input_allowed(val: bool) -> void:
	input_allowed = val


func _on_obstacle_body_entered(_area) -> void:
	die()

