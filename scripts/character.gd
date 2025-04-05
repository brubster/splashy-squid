extends CharacterBody2D


signal death_flash


@export var gravity: float = 2000.0
@export var splash_velocity: float = -600.0


@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D


var input_allowed: bool
var is_dead: bool


func _ready() -> void:
	set_input_allowed(false)
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
		# _unhandled_input is used to gather input
	elif is_on_floor():
		# Prevent weird sliding after death animation
		set_physics_process(false)
	
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if is_dead:
		return
	if event.is_action_pressed("splash"):
		velocity.y = splash_velocity


func handle_rotation() -> void:
	var splash_lerp: float = lerpf(get_rotation_degrees(), (velocity.y * 0.5) - 100.0, 0.05)
	var splash_rotation: float = clampf(splash_lerp, -35.0, 85.0)
	set_rotation_degrees(splash_rotation)


# Die by an obstacle
func die() -> void:
	if is_dead:
		return
	
	death_flash.emit()
	anim_sprite.stop()
	velocity.y = splash_velocity  # final "splash", makes hit more impactful   
	
	set_process_mode(ProcessMode.PROCESS_MODE_ALWAYS)
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
	anim_sprite.stop()
	velocity.y = splash_velocity + 400.0
	
	set_process_mode(ProcessMode.PROCESS_MODE_ALWAYS)
	var tree = get_tree()
	tree.set_pause(true)
	
	is_dead = true
	
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "rotation", deg_to_rad(90.0), 0.05)


func _game_ready() -> void:
	set_input_allowed(true)
	anim_sprite.play()
	show()
	set_physics_process(true)
	velocity.y = splash_velocity
	move_and_slide()


func _game_restart() -> void:
	set_input_allowed(false)
	hide()
	anim_sprite.stop()
	set_process_mode(ProcessMode.PROCESS_MODE_INHERIT)
	set_physics_process(false)
	set_position(Vector2(212.0, 400.0))
	is_dead = false


func set_input_allowed(val: bool) -> void:
	input_allowed = val


func _on_obstacle_body_entered(_area) -> void:
	die()
