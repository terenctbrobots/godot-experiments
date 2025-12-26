extends CharacterBody3D

@export var _walk_speed : float = 1
@export var _run_speed : float = 2
@export var _acceleration : float = 4
@export var _deceleration : float = 8
@onready var _gravity : float = ProjectSettings.get("physics/3d/default_gravity")
var _direction : Vector3
var _xz_velocity : Vector3
var facing : int
var is_walking : bool
var is_running : bool
var wants_to_run : bool

func _ready() -> void:
	$Sprite3D.rotation.y = deg_to_rad(30)

func move(direction : Vector3, _facing : int) -> void:
	_direction = direction
	if _direction != Vector3.ZERO and _facing != -1:
		facing = _facing

func run(should_run : bool) -> void:
	wants_to_run = should_run

func _physics_process(delta: float) -> void:
	_xz_velocity = Vector3(velocity.x, 0, velocity.z)
	if not is_on_floor():
		velocity.y -= _gravity * delta
	if _direction == Vector3.ZERO:
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta)
	else:
		if _direction.dot(_xz_velocity.normalized()) > 0:
			_xz_velocity = _xz_velocity.move_toward(_direction * (_run_speed if is_running else _walk_speed), _acceleration * delta)
		else:
			_xz_velocity = _xz_velocity.move_toward(_direction * (_run_speed if is_running else _walk_speed), _deceleration * delta)
	if _xz_velocity == Vector3.ZERO:
		is_walking = false
		is_running = false
	else:
		is_walking = not wants_to_run
		is_running = wants_to_run
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z
	move_and_slide()
