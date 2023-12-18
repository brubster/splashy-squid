extends CharacterBody2D


@export var gravity: float = 980.0
@export var flap_velocity: float = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += gravity * delta
	
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

