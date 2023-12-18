extends CharacterBody2D


@export var gravity: float = 2000.0
@export var flap_velocity: float = -600.0


var is_dead: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta
	
	if not is_dead:
		handle_rotation()
		handle_input()
	
	move_and_slide()


func handle_input() -> void:
	# Flap
	if Input.is_action_just_pressed("flap"):
		velocity.y = flap_velocity


func handle_rotation() -> void:
	var flap_lerp: float = lerpf(get_rotation_degrees(), (velocity.y * 0.5) - 100.0, 0.05)
	var flap_rotation: float = clampf(flap_lerp, -35.0, 85.0)
	set_rotation_degrees(flap_rotation)


func die() -> void:
	var tree = get_tree()
	tree.set_pause(true)
	
	is_dead = true
	
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.4)
	# TODO: make screen flash white


func _on_obstacle_body_entered(_area) -> void:
	die()

