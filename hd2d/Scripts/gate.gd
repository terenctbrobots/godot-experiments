extends Node3D

@export var room_id : Array[int]
@export var _open_trans : Tween.TransitionType
@export var _open_ease : Tween.EaseType
@export var _close_trans : Tween.TransitionType
@export var _close_ease : Tween.EaseType
@export var _duration : float = 1
@export var _reverse_swing : bool
@onready var _hinge: Node3D = $Hinge
var _tween : Tween
var _is_open : bool
var _is_locked : bool
var _body_entered_from_front : bool
var _body_exited_from_front : bool

signal player_walked_through_door(to_room_id : int)

func open(clockwise : bool = false) -> void:
	_tween = create_tween().set_trans(_open_trans).set_ease(_open_ease)
	_tween.tween_property(_hinge, "rotation:y", deg_to_rad(88 * (-1 if _reverse_swing else 1)) * (1 if clockwise else -1), _duration)

func close() -> void:
	_tween = create_tween().set_trans(_close_trans).set_ease(_close_ease)
	_tween.tween_property(_hinge, "rotation:y", 0, _duration)

func _on_trigger_body_entered(body: Node3D) -> void:
	_body_entered_from_front = body.position.z > position.z
	if not _is_locked and not _is_open:
		open(_body_entered_from_front)

func _on_trigger_body_exited(body: Node3D) -> void:
	_body_exited_from_front = body.position.z > position.z
	if _body_entered_from_front and not _body_exited_from_front:
		player_walked_through_door.emit(room_id[0])
		close()
	elif not _body_entered_from_front and _body_exited_from_front:
		player_walked_through_door.emit(room_id[1])
		close()
