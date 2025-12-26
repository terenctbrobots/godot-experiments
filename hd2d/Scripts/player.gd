extends Node

@onready var _character : CharacterBody3D = get_parent()
@onready var _camera: Camera3D = %Camera
var _input_direction : Vector2
var _move_direction : Vector3
var _facing : int

func _process(_delta: float) -> void:
	_input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.25)
	_move_direction = (_camera.basis.x * Vector3(1, 0, 1)).normalized() * _input_direction.x
	_move_direction += (_camera.basis.z * Vector3(1, 0, 1)).normalized() * _input_direction.y
	if _input_direction == Vector2.ZERO:
		_facing = -1
	elif _move_direction.dot((_camera.basis.z * Vector3(1, 0, 1)).normalized()) < -0.5:
		_facing = 2
	elif _move_direction.dot((_camera.basis.x * Vector3(1, 0, 1)).normalized()) > 0.5:
		_facing = 1
	elif _move_direction.dot((_camera.basis.x * Vector3(1, 0, 1)).normalized()) < -0.5:
		_facing = 3
	else:
		_facing = 0
	_character.move(_move_direction, _facing)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	elif event.is_action_pressed("run"):
		_character.run(true)
	elif event.is_action_released("run"):
		_character.run(false)
